# frozen_string_literal: true

module Eunomia
  module Segment
    # Reference represents a link to a Generator defined with square brackets.
    class Reference
      include Common

      REFERENCE_MATCHER = /^\[([A-Za-z][A-Za-z0-9_-]+)(?::([0-9]+))?\]/

      attr_reader :key, :version

      def initialize(key, version = 0)
        @key = key
        @version = version
      end

      def generate(request, alts: {}, functions: [])
        return request.append(Eunomia::Element.new(request.constants[lookup])) if request.constants.key?(lookup)

        request.increase_depth
        g = Eunomia::STORE.lookup(lookup)
        g.generate(request, alts: alts.merge(g.alts), functions: Set.new(functions + g.functions).to_a)
      end

      def lookup
        @lookup ||= version.zero? ? key : "#{key}:#{version}"
      end

      def self.build(scanner)
        str = scanner.scan(REFERENCE_MATCHER)
        return unless str

        new(scanner[1], scanner[2].to_i)
      end
    end
  end
end
