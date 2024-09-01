# frozen_string_literal: true

module Eunomia
  module Segment
    class Number
      include Common

      NUMBER_MATCHER = /(\d+)/

      attr_reader :text, :multipler

      def initialize(number)
        @multiplier = number.to_i
        @text = number.to_s
      end

      def self.build(scanner)
        str = scanner.scan(NUMBER_MATCHER)
        new(str) if str
      end
    end
  end
end
