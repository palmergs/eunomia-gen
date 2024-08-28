# frozen_string_literal: true

module Eunomia
  module Segment
    class Number
      NUMBER_MATCHER = /(\d+)/

      attr_reader :multipler, :number

      def initialize(number)
        @multiplier = number.to_i
        @number = number.to_s
      end

      def generate request, response
        response.append(:number, number, multiplier:)
      end

      def self.build(scanner)
        str = scanner.scan(NUMBER_MATCHER)
        new(str) if str
      end
    end
  end
end
