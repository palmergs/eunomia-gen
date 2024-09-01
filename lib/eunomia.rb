# frozen_string_literal: true

require_relative "eunomia/version"
require_relative "eunomia/selector"
require_relative "eunomia/generator"
require_relative "eunomia/item"
require_relative "eunomia/element"
require_relative "eunomia/request"
require_relative "eunomia/result"
require_relative "eunomia/segment"
require_relative "eunomia/function"

module Eunomia
  class Error < StandardError; end

  class Store
    def initialize
      @store = {}
    end

    def lookup(key)
      @store[key] or raise Error, "Generator #{key} not found"
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
        @store[gen.key] = gen
        @store[gen.key_with_version] = gen
      end
    end
  end

  STORE = Store.new
end
