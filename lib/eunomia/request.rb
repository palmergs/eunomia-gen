# frozen_string_literal: true

module Eunomia
  # Encapsuate a request for string generation
  class Request < Eunomia::Generator
    # If not nil, a set of value strings; this is
    # Persisted across calls to generate
    attr_reader :unique

    # If given, alts are chosen from the given locale key
    attr_reader :locale

    # The current depth (calls to generate) for the run
    attr_reader :depth

    def initialize(key, alts: {}, locale: nil, constants: {}, filters: [], functions: [], unique: false)
      hsh = { key:, items: ["request"], alts:, constants:, filters:, gen: "sequence", functions: }
      @unique = unique ? Set.new : nil
      @depth = 0
      @locale = locale
      super(hsh)
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
        return result if passes_filters?(result) && (!unique || unique.add?(result.to_s))
      end

      raise "Unable to find a unique result that passes filters"
    end
  end
end
