# frozen_string_literal: true

module Eunomia
  class Generator
    class Selector
      DICE_MATCHER = /^(\d+)?d(\d+)?/

      attr_reader :max, :count, :range

      def initialize(max, dice = nil)
        @max = max
        @count = 0
        @range = max
        return unless dice

        m = DICE_MATCHER.match(dice)
        return unless m

        @count = m[1].to_i.clamp(1, [max / 4, 1].max)
        @range = m[2].to_i.clamp(1, max)
      end

      def select(items)
        n = random
        n = random while n >= max

        items.each do |item|
          n -= item.weight
          return item if n.negative?
        end
      end

      def random
        if count.positive?
          sum = 0
          count.times { sum += rand(range) }
          sum
        else
          rand(max)
        end
      end
    end

    attr_reader :key,
                :version,
                :alts,
                :selector,
                :functions,
                :tags,
                :items,
                :weight,
                :sep

    def initialize(hsh)
      @key = hsh[:key] or raise "Generators must have a key"
      @version = hsh[:version].to_i
      @functions = hsh[:functions] || []
      @alts = hsh[:alts] || {}
      @tags = Set.new(hsh[:tags] || [])
      @weight = 0
      @sep = hsh[:sep] || ""
      @items = hsh[:items].map do |item|
        item = Eunomia::Item.new(item)
        @weight += item.weight
        item
      end
      raise "Generators must have items" unless @items.present?

      @selector = Selector.new(@weight, hsh[:selector])
    end

    def sep?
      sep.present?
    end

    def generate(store, request)
      item = selector.select(items, weight)
      item.generate(store, request)
    end

    def self.build(hsh)
      hsh = HashWithIndifferentAccess.new(hsh)
      new(hsh)
    end
  end
end
