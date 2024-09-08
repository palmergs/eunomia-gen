# frozen_string_literal: true

module Eunomia
  # Selector defines a strategy for selecting an item from a list of items.
  # The default behavior is to randomly generate a number between 0 and the
  # sum of the weights of the items and select the first match.
  #
  # Alternately, a dice notation string can be provided to generate a random
  # number based on the dice notation. The dice notation is shifted down based
  # on the number of dice so that, for example, 2d6 will generate a number
  # between 0 and 10.
  #
  # If the dice notation is less than the total weight of the items the
  # items greater than the maxumum value are ignored. If the dice notation is
  # greater than the total weight of the items the number is regenerated.
  class Selector
    DICE_MATCHER = /^(\d+)?d(\d+)?/

    attr_reader :count, :range

    def initialize(dice = nil)
      @count = nil
      @range = nil
      return unless dice

      m = DICE_MATCHER.match(dice)
      return unless m

      @count = m[1].to_i.clamp(1, 100)
      @range = m[2].to_i.clamp(1, 10_000)
    end

    def select(items)
      n = random(items)
      items.each do |item|
        n -= item.weight
        return item if n.negative?
      end
      nil
    end

    def random(items)
      max_weight = items.map(&:weight).sum
      if count.nil? || count >= max_weight
        rand(max_weight)
      else
        n = roll
        n /= 2 while n >= max_weight
        n
      end
    end

    def roll
      sum = 0
      count.times { sum += rand(range) }
      sum
    end
  end
end
