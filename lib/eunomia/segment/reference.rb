# frozen_string_literal: true

module Eunomia
  module Segment
    class Reference
      REFERENCE_MATCHER = /^\[([A-Za-z][A-Za-z0-9_-]+)(?::([0-9]+))?\]/

      attr_reader :key, :version

      def initialize(key, version = 0)
        @key = key
        @version = version
      end

      def value(_cache)
        Eunomia::Value.new(key)
      end

      def self.build(scanner)
        str = scanner.scan(REFERENCE_MATCHER)
        return unless str

        new(scanner[1], scanner[2].to_i)
      end
    end
  end
end
