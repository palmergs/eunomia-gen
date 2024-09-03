# frozen_string_literal: true

module Eunomia
  # Generator consists of a list of Items. When generating a result,
  # an item is selected at random based on the item's weight.
  class Generator
    attr_reader :key,
                :version,
                :alts,
                :functions,
                :tags,
                :items,
                :selector,
                :sep

    def initialize(hsh)
      @key = hsh[:key] or raise "Generators must have a key"
      @version = hsh[:version].to_i
      @functions = hsh[:functions] || []
      @alts = hsh[:alts] || {}
      @tags = Set.new(hsh[:tags] || [])
      @weight = 0
      @sep = hsh[:sep] || ""
      @selector = Eunomia::Selector.new(hsh[:rng])
      @items = hsh[:items].map { |item| Eunomia::Item.new(item) }
      raise "Generators must have items" if @items.empty?
    end

    def key_with_version
      @key_with_version ||= "#{key}:#{version}"
    end

    def sep?
      sep.present?
    end

    def alt_for(key, segment)
      return segment unless key
      return segment unless alts[key]

      alts[key][segment] || segment
    end

    # Select items that have all the given tag values
    def filter(tags)
      items.select { |item| (tags - item.tags).empty? }
    end

    def generate(request)
      items = filter(request.tags)
      item = selector.select(items)
      raise "No items found for #{key_with_version}" unless item

      result = item.generate(request)
      result.apply(alts, functions, locale: request.alt_key)
      result
    end

    def self.build(hsh)
      hsh = HashWithIndifferentAccess.new(hsh)
      new(hsh)
    end
  end
end
