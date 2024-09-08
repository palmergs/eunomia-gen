# frozen_string_literal: true

module Eunomia
  # Generator consists of a list of Items. When generating a result,
  # an item is selected at random based on the item's weight.
  class Generator
    include Eunomia::HashHelpers

    attr_reader :key,
                :alts,
                :meta,
                :functions,
                :tags,
                :items,
                :selector,
                :sep

    def initialize(hsh)
      @key = field_or_raise(hsh, :key)
      @functions = list_field(hsh, :functions)
      @alts = hash_field(hsh, :alts)
      @meta = meta_field(hsh)
      @tags = tags_field(hsh)
      @selector = Eunomia::Selector.new(field_or_nil(hsh, :rng))
      @items = items_from(hsh)
      raise "Generators must have items" if @items.empty?
    end

    def items_from(hsh)
      list_field(hsh, :items).map do |item|
        item = { segments: item } if item.is_a?(String)
        Eunomia::Item.new(@key, item, @tags)
      end
    end

    def alt_for(key, segment)
      return segment unless key
      return segment unless alts[key]

      alts[key][segment] || segment
    end

    # Select items that have all the given tag values
    def filter(tags)
      return items if tags.empty?

      items.select { |item| (tags - item.tags).empty? }
    end

    def generate(request)
      items = filter(request.tags)
      item = selector.select(items)
      raise "No items found for #{key}" unless item

      result = item.generate(request)
      result.apply(alts, functions, locale: request.alt_key)
      result.merge_meta(meta)
      result
    end
  end
end
