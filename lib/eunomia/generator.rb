# frozen_string_literal: true

module Eunomia
  # Generator consists of a list of Items. When generating a result,
  # an item is selected at random based on the item's weight.
  class Generator
    include Eunomia::HashHelpers

    attr_reader :key,
                :aliases,
                :alts,
                :meta,
                :functions,
                :tags,
                :gen,
                :items,
                :selector

    def initialize(hsh)
      @key = field_or_raise(hsh, :key)
      @aliases = list_field(hsh, :aliases)
      @functions = list_field(hsh, :functions)
      @alts = hash_field(hsh, :alts)
      @meta = meta_field(hsh)
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
      result.apply(alts, functions, locale: request.alt_key)
      result.merge_meta(meta)
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
      hsh = { key: }
      hsh[:aliases] = aliases unless aliases.empty?
      hsh[:gen] = gen
      hsh[:items] = items.map(&:to_h)
      hsh[:tags] = tags.to_a unless tags.empty?
      hsh[:alts] = alts unless alts.empty?
      hsh[:meta] = meta unless meta.empty?
      hsh[:functions] = functions unless functions.empty?
      hsh
    end
  end
end
