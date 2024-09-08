# frozen_string_literal: true

module Eunomia
  class Request
    attr_reader :key, :alt_key, :alts, :meta, :tags, :functions, :constants, :depth

    def initialize(key, alts: {}, alt_key: nil, meta: {}, tags: [], functions: [], constants: {}, unique: false)
      @key = key
      @alt_key = alt_key
      @alts = alts || {}
      @meta = meta || {}
      @tags = Set.new(tags || [])
      @constants = constants || {}
      @functions = functions || []
      @depth = 0
      @unique = unique ? Set.new : nil
    end

    def generate_unique?
      !@unique.nil?
    end

    def alt_key?
      !alt_key.nil?
    end

    def alt_for(segment)
      alts[segment] || segment
    end

    def increase_depth
      @depth += 1
      raise "Depth exceeded" if @depth > 100
    end

    def generate
      @depth = 0
      gen = Eunomia.lookup(key)

      100.times do
        result = gen.generate(self)
        result.apply(alts, functions)
        return result if !@unique || @unique.add?(result.to_s)
      end

      raise "Unable to find a unique result"
    end
  end
end
