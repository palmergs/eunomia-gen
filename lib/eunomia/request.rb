# frozen_string_literal: true

module Eunomia
  class Request
    attr_reader :key, :alt_key, :alts, :meta, :tags, :functions, :constants, :depth

    def initialize(key, alts: {}, alt_key: nil, meta: {}, tags: [], functions: [], constants: {}, unique: false)
      @key = key
      @alt_key = alt_key
      @alts = alts || {}
      @meta = meta || {}
      @tags = tags || {}
      @constants = constants || {}
      @functions = functions || {}
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
      gen = Eunomia::STORE.lookup(key)

      tries = 0
      loop do
        result = gen.generate(self)
        result.apply(alts, functions)
        return result unless @unique
        return result if @unique.add?(result.to_s)

        tries += 1
        raise "Unable to find a unique result" if tries > 100
      end
    end
  end
end
