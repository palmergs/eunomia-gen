module Eunomia
  module Segment
    class Number
      NUMBER_MATCHER = /(\d+)/

      attr_reader :multipler, :number

      def initialize number
        @multiplier = number.to_i
        @number = number.to_s
        @value = Eunomia::Value.new(@number, multiplier: @multiplier)
      end

      def value
        @value
      end

      def self.build scanner
        str = scanner.scan(NUMBER_MATCHER)
        new(str) if str
      end
    end
  end
end
