# frozen_string_literal: true

module Eunomia
  module Segment
    # Represents a number in a segment. The value
    # is the multiplier for the item.
    class Number
      include Common

      NUMBER_MATCHER = /([+-]?\d+)/

      attr_reader :text, :multipler

      def initialize(number)
        @multiplier = number.to_i
        @text = number.to_s
      end

      def to_s
        text
      end

      def self.build(scanner)
        str = scanner.scan(NUMBER_MATCHER)
        new(str) if str
      end
    end
  end
end
