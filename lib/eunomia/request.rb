# frozen_string_literal: true

module Eunomia
  class Request
    attr_reader :key, :alt_key, :alts, :meta, :tags, :functions, :constants, :depth

    def initialize(key, alts: {}, alt_key: nil, meta: {}, tags: [], functions: [], constants: {})
      @key = key
      @alt_key = alt_key
      @alts = alts || {}
      @meta = meta || {}
      @tags = tags || {}
      @constants = constants || {}
      @functions = functions || {}
      @depth = 0
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
      result = Eunomia::STORE.lookup(key).generate(self)
      result.apply(alts, functions)
      result
    end
  end
end
