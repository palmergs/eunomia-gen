# frozen_string_literal: true

module Eunomia
  # Item represents a single selectable row of a generator.
  class Item
    include Eunomia::HashHelpers

    attr_reader :key,
                :weight,
                :value,
                :alts,
                :meta,
                :functions,
                :segments

    def initialize(key, hsh)
      @key = key
      @weight = int_field(hsh, :weight).clamp(1, 1000)
      @value = int_field(hsh, :value).clamp(0, 1_000_000)
      @alts = alts_field(hsh)
      @meta = meta_field(hsh)
      @functions = list_field(hsh, :functions)
      @segments = scan(field_or_raise(hsh, :segments)).flatten
    end

    def meta_keys
      @meta_keys ||= (Set.new(meta.keys) + segments.map(&:meta_keys).inject(&:merge))
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
      result = Eunomia::Result.new(key, value:)
      segments.each { |seg| result.append(seg.generate(request)) }
      result.apply(alts, functions, locale: request.locale)
      result.merge_meta(meta)
      result
    end

    def to_h
      hsh = {
        segments: segments.map(&:to_s).join,
        weight:
      }

      hsh[:value] = value if value != 0
      hsh[:meta] = meta unless meta.empty?
      hsh[:functinos] = functions unless functions.empty?
      hsh
    end
  end
end
