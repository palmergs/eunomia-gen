# frozen_string_literal: true

require_relative "function/capitalize"
require_relative "function/downcase"
require_relative "function/pluralize"
require_relative "function/quote"
require_relative "function/titleize"
require_relative "function/upcase"

module Eunomia
  # Function module contains functions that can be applied to an array of strings.
  class Functions
    def initialize
      @functions = {
        "capitalize" => Eunomia::Function::Capitalize.new,
        "downcase" => Eunomia::Function::Downcase.new,
        "pluralize" => Eunomia::Function::Pluralize.new,
        "quote" => Eunomia::Function::Quote.new,
        "titleize" => Eunomia::Function::Titleize.new,
        "upcase" => Eunomia::Function::Upcase.new
      }
    end

    def apply(arr, funcs)
      funcs.each do |function|
        arr = @functions[function].apply(arr)
      end
      arr
    end

    def add(name, function)
      @functions[name] = function
    end
  end
end
