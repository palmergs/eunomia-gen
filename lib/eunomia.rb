# frozen_string_literal: true

require_relative "eunomia/version"
require_relative "eunomia/value"
require_relative "eunomia/generator"
require_relative "eunomia/segment"
require_relative "eunomia/function"

module Eunomia
  class Error < StandardError; end

  class Store
    def generate key
      # TODO
    end

    def read path
      text = File.read(path)
      hsh_or_array = JSON.parse(text)
      add(hsh_or_array)
    end

    def add hsh_or_array
      if hsh_or_array.is_a?(Array)
        hsh_or_array.each do |item|
          add(item)
        end
      else
        
      end
    end
  end
end
