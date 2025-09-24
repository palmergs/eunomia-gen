# frozen_string_literal: true

module Eunomia
  # Generator consists of a list of Items. When generating a result,
  # an item is selected at random based on the item's weight.
  class Generator
    include Eunomia::HashHelpers

    # Normalized identifier for this generator
    attr_reader :key

    # Key value pairs of string values to swap out for this generator results
    attr_reader :alts

    # Key vaule pair of generator keys to values; if the key is seen the value is replaced
    # with the constant value
    attr_reader :constants

    # Functions to apply to the generated string from this generator
    attr_reader :functions

    # Tags that must match to the item tags to be selected
    attr_reader :tags

    # Are the items selected in order (sequence) or random
    attr_reader :gen

    # The items in this generator
    attr_reader :items

    # The random number generator used to select items
    attr_reader :selector

    def initialize(hsh)
      @key = field_or_raise(hsh, :key)
      @functions = list_field(hsh, :functions)
      @alts = hash_field(hsh, :alts)
      @constants = hash_field(hsh, :constants)
      @tags = tags_field(hsh)
      @gen = field_or_nil(hsh, :gen).to_s == "sequence" ? :sequence : :random
      @selector = Eunomia::Selector.new(field_or_nil(hsh, :rng))
      @items = items_from(hsh)
      raise "Generators must have items" if @items.empty?
    end

    def random?
      gen == :random
    end

    def sequence?
      !random?
    end

    def items_from(hsh)
      list_field(hsh, :items).map do |item|
        item = { segments: item } if item.is_a?(String)
        Eunomia::Item.new(@key, item, @tags)
      end
    end

    def item_tags
      @item_tags ||= begin
        set = Set.new
        items.each { |item| set += item.available_tags }
        set
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

      items.select { |item| item.match_tags?(tags) }
    end

    def generate(request)
      items = filter(request.tags)
      raise "no items matched tags" if items.empty?

      if random?
        generate_random(request, items)
      else
        generate_sequence(request, items)
      end
    end

    def generate_random(request, items)
      item = selector.select(items)
      raise "No items found for #{key}" unless item

      result = item.generate(request)
      result.apply(alts, functions, locale: request.locale)
      result
    end

    def generate_sequence(request, items)
      result = Eunomia::Result.new(key)
      items.each do |item|
        result.append(item.generate(request))
      end
      result
    end

    def to_h
      hsh = { key:, gen:, items: items.map(&:to_h) }
      hsh[:rng] = selector if selector.count
      hsh[:tags] = tags.to_a unless tags.empty?
      hsh[:alts] = alts unless alts.empty?
      hsh[:functions] = functions unless functions.empty?
      hsh
    end
  end
end
