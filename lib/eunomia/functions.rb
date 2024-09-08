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
        "capitalize" => Eunomia::Function::Capitalize.new.to_proc,
        "downcase" => Eunomia::Function::Downcase.new.to_proc,
        "pluralize" => Eunomia::Function::Pluralize.new.to_proc,
        "quote" => Eunomia::Function::Quote.new.to_proc,
        "titleize" => Eunomia::Function::Titleize.new.to_proc,
        "upcase" => Eunomia::Function::Upcase.new.to_proc
      }
    end

    def apply(arr, funcs)
      funcs.each do |function|
        arr = @functions[function].call(arr)
      end
      arr
    end

    def add(name, proc)
      @functions[name.to_s] = proc
    end
  end
end
