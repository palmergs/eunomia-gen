# frozen_string_literal: true

require_relative "function/capitalize"
require_relative "function/downcase"
require_relative "function/pluralize"
require_relative "function/quote"
require_relative "function/titleize"
require_relative "function/upcase"

module Eunomia
  # Function module contains functions that can be applied to an array of strings.
  module Function
    def self.apply(arr, functions)
      functions.each { |function| arr = FUNCTIONS[function].apply(arr) }

      arr
    end

    FUNCTIONS = {
      "capitalize" => Eunomia::Function::Capitalize.new,
      "downcase" => Eunomia::Function::Downcase.new,
      "pluralize" => Eunomia::Function::Pluralize.new,
      "quote" => Eunomia::Function::Quote.new,
      "titleize" => Eunomia::Function::Titleize.new,
      "upcase" => Eunomia::Function::Upcase.new
    }.freeze
  end
end
