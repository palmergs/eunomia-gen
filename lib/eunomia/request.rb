module Eunomia
  class Request
    def initialize key, alt:, meta:, tags:
      @key = key
      @alt = alt || {}
      @meta = meta || {}
      @tags = tags || {}
    end

    def generate count: 1
      store = Eunomia::STORE
      store.generate(key, self)
    end
  end
end
