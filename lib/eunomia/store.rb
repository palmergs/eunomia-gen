module Eunomia
  # Store holds all the generators. Generators are stored by key.
  class Store
    def initialize
      @generators = {}
    end

    def lookup(key)
      @generators[key] or raise Error, "Generator #{key} not found"
    end

    def read(path)
      text = File.read(path)
      hsh_or_array = JSON.parse(text)
      add(hsh_or_array)
    end

    def add(hsh_or_array)
      return unless hsh_or_array

      if hsh_or_array.is_a?(Array)
        hsh_or_array.each do |item|
          add(item)
        end
      else
        gen = Eunomia::Generator.new(hsh_or_array)
        @generators[gen.key] = gen
      end
    end
  end
end
