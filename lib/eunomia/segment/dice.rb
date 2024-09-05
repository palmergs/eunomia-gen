# frozen_string_literal: true

module Eunomia
  module Segment
    # Dice generates a random number using dice notation (e.g. `[3d6]`)
    # with common operators (e.g. `[3d6+2]` or `[4d10x2]`)
    # All values are integers so using the division operator
    # will be rounded down.
    class Dice
      include Common

      DICE_MATCHER = %r{\[(\d+)?d(\d+)(?:([+x/-])(\d+))?\]}
      ADD = "+"
      MULTIPLY = "x"
      SUBTRACT = "-"
      DIVIDE = "/"
      OPS = [ADD, MULTIPLY, SUBTRACT, DIVIDE].freeze

      attr_reader :count, :range, :op, :constant

      def initialize(count, range, op = ADD, constant = 0)
        @count = count.to_i.clamp(1, 100)
        @range = range.to_i.clamp(1, 1_000_000)
        @op = OPS.include?(op) ? op : ADD
        @constant = constant.to_i.clamp(0, 1_000_000)
        @value = nil
      end

      def roll
        sum = 0
        count.times do
          sum += (rand(range) + 1)
        end
        sum
      end

      def calc
        @multipler = nil
        case op
        when MULTIPLY
          roll * constant
        when DIVIDE
          roll / constant
        when SUBTRACT
          roll - constant
        when ADD
          roll + constant
        end
      end

      def text
        @multiplier ||= calc
        @multiplier.to_s
      end

      def multiplier
        @multiplier ||= calc
      end

      def self.build(scanner)
        str = scanner.scan(DICE_MATCHER)
        return unless str

        new(scanner[1], scanner[2], scanner[3], scanner[4])
      end
    end
  end
end
