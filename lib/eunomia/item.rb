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
      @weight = hsh[:weight].to_i.clamp(1, 1000)
      @value = hsh[:value].to_i.clamp(0, 1_000_000)
      @tags = hsh[:tags] || []
      @alts = hsh[:altes] || {}
      @meta = hsh[:meta] || {}
      @functions = hsh[:functions] || []
      @sep = hsh[:sep]
      @segments = scan(hsh[:segments]).flatten
      raise "Items must have segments" unless @segments.present?
    end

    def sep?
      sep.present?
    end

    def scan(obj)
      return [] if obj.nil?
      return obj.map { |e| scan(e) } if obj.is_a?(Array)

      Segment.build(str)
    end

    def generate(_store, _request)
      segments.map do |segment|
      end
    end
  end
end
