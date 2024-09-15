# frozen_string_literal: true

module Eunomia
  # Item represents a single selectable row of a generator.
  class Item
    include Eunomia::HashHelpers

    attr_reader :key,
                :weight,
                :value,
                :tags,
                :alts,
                :meta,
                :functions,
                :segments

    def initialize(key, hsh, add_tags = nil)
      @key = key
      @weight = int_field(hsh, :weight).clamp(1, 1000)
      @value = int_field(hsh, :value).clamp(0, 1_000_000)
      @alts = alts_field(hsh)
      @meta = meta_field(hsh)
      @functions = list_field(hsh, :functions)
      @segments = scan(field_or_raise(hsh, :segments)).flatten
      @tags = tags_field(hsh)
      @tags += add_tags if add_tags
      @available_tags = nil
    end

    def available_tags
      @available_tags ||= begin
        s = Set.new
        refs = segments.filter { |seg| seg.is_a?(Eunomia::Segment::Reference) }
        unless refs.empty?
          s = refs[0].item_tags
          refs[1..].each { |ref| s &= ref.item_tags }
        end
        s
      end
    end

    def scan(obj)
      return [] if obj.nil?
      return Eunomia::Segment.build(obj.to_s) unless obj.is_a?(Array)

      obj.map { |e| Eunomia::Segment.build(e) }.flatten
    end

    def match_tags?(tags)
      return true if tags.nil? || tags.empty?
      return true if (tags - self.tags).empty?
      return true if (tags - available_tags).empty?

      false
    end

    def alt_for(key, segment)
      return segment unless key
      return segment unless alts[key]

      alts[key][segment] || segment
    end

    def generate(request)
      result = Eunomia::Result.new(key, value: value)
      segments.each { |seg| result.append(seg.generate(request)) }
      result.apply(alts, functions, locale: request.alt_key)
      result.merge_meta(meta)
      result.add_tags_as_meta(tags)
      result
    end
  end
end
