# frozen_string_literal: true

module Eunomia
  module Segment
    class Dice
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
      end

      def roll
        sum = 0
        count.times do
          sum += (rand(range) + 1)
        end
        sum
      end

      def calc
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

      def generate request, response
        n = calc
        s = n.to_s
        response.append(:dice, s, multiplier: n)
      end

      def self.build(scanner)
        str = scanner.scan(DICE_MATCHER)
        return unless str

        new(scanner[1], scanner[2], scanner[3], scanner[4])
      end
    end
  end
end
