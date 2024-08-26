module Eunomia
  class Value
    attr_reader :key, :value, :multiplier, :right

    def initialize(key, value: 0, multiplier: 0)
      @key = key.to_s
      @value = value
      @multiplier = multiplier
    end

    # Swap the current string for an alternate if defined
    def swap(generator, item, request)
      request.swap[key] || item.swap[key] || generator.swap[key] || key
    end
  end
end
