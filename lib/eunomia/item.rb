# frozen_string_literal: true

module Eunomia
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
      @tags = tags_field(hsh)
      @tags += add_tags if add_tags
      @alts = alts_field(hsh)
      @meta = meta_field(hsh)
      @functions = list_field(hsh, :functions)
      @segments = scan(field_or_raise(hsh, :segments)).flatten
      raise "Items must have segments" if @segments.empty?
    end

    def scan(obj)
      return [] if obj.nil?
      return Eunomia::Segment.build(obj.to_s) unless obj.is_a?(Array)

      obj.map { |e| Eunomia::Segment.build(e) }.flatten
    end

    def alt_for(key, segment)
      return segment unless key
      return segment unless alts[key]

      alts[key][segment] || segment
    end

    def generate(request)
      result = Eunomia::Result.new(key, value: value)
      result.merge_meta(meta)
      segments.each { |seg| result.append(seg.generate(request)) }
      all_alts = alts.merge(request.alts)
      all_functs = Set.new(functions + request.functions)
      result.apply(all_alts, all_functs, locale: request.alt_key)
      result
    end
  end
end
