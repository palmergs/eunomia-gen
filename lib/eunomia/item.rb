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
      @alts = hsh[:altes] || {}
      @meta = hsh[:meta] || {}
      @functions = hsh[:functions] || []
      @sep = hsh[:sep]
      @segments = scan(hsh[:segments]).flatten
      raise "Items must have segments" if @segments.empty?
    end

    def sep?
      sep.present?
    end

    def scan obj
      return [] if obj.nil?
      return Eunomia::Segment.build(obj.to_s) unless obj.is_a?(Array)

      obj.map {|e| Eunomia::Segment.build(e) }.flatten
    end

    def generate request, response
      item_response = Eunomia::Response.new
      segments.each do |segment|
        segment.generate(request, item_response)
      end
      response.append(item_response)
    end
  end
end
