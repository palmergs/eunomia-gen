# frozen_string_literal: true

module Eunomia
  module Segment
    # Reference represents a link to a Generator defined with square brackets.
    # A request may define a constant that is used in place of a generator to
    # return a specific value. This can be identified with a label so that the
    # substitution is only used in specific context. For example `[test]` would
    # first look for a constant named `test` and if not found, get the generator
    # from the store. `[test:label]` would only use the constant if the request
    # has a constant key if `test:label` and, otherwise, use the generator
    # called `test`.
    class Reference
      include Common

      REFERENCE_MATCHER = /^\[([A-Za-z][A-Za-z0-9_-]+)(?::([A-Za-z0-9_-]+))?\]/

      attr_reader :key, :label

      def initialize(key, label = nil)
        @key = key
        @label = label
      end

      def label?
        !label.nil?
      end

      def generate(request)
        return Eunomia::Element.new(request.constants[lookup]) if request.constants.key?(lookup)

        request.increase_depth
        Eunomia.generate(key, request)
      end

      def lookup
        @lookup ||= label.nil? ? key : "#{key}:#{label}"
      end

      def self.build(scanner)
        str = scanner.scan(REFERENCE_MATCHER)
        return unless str

        new(scanner[1], scanner[2])
      end
    end
  end
end
