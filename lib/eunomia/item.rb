# frozen_string_literal: true

module Eunomia
  class Item
    attr_reader :weight,
                :value,
                :tags,
                :alts,
                :meta,
                :functions,
                :sep,
                :segments

    def initialize(hsh)
      hsh = { segments: hsh } if hsh.is_a?(String)
      @weight = hsh[:weight].to_i.clamp(1, 1000)
      @value = hsh[:value].to_i.clamp(0, 1_000_000)
      @tags = hsh[:tags] || []
      @alts = hsh[:alts] || {}
      @meta = hsh[:meta] || {}
      @functions = hsh[:functions] || []
      @sep = hsh[:sep]
      @segments = scan(hsh[:segments]).flatten
      raise "Items must have segments" if @segments.empty?
    end

    def sep?
      sep.present?
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
      result = Eunomia::Result.new(:item, value: value)
      result.meta.merge!(meta)
      segments.each { |seg| result.append(seg.generate(request)) }
      all_alts = alts.merge(request.alts)
      all_functs = Set.new(functions + request.functions)
      result.apply(all_alts, all_functs, locale: request.alt_key)
      result
    end
  end
end
