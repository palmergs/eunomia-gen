# frozen_string_literal: true

require_relative "function/capitalize"
require_relative "function/downcase"
require_relative "function/pluralize"
require_relative "function/quote"
require_relative "function/titleize"
require_relative "function/upcase"

module Eunomia
  # Function module contains functions that can be applied to a string.
  module Function
    def self.apply(str, functions)
      return str if functions.empty?

      functions.each do |function|
        str = case function
              when "capitalize"
                Eunomia::Function::Capitalize.new.apply(str)
              when "downcase"
                Eunomia::Function::Downcase.new.apply(str)
              when "pluralize"
                Eunomia::Function::Pluralize.new.apply(str)
              when "quote"
                Eunomia::Function::Quote.new.apply(str)
              when "titleize"
                Eunomia::Function::Titleize.new.apply(str)
              when "upcase"
                Eunomia::Function::Upcase.new.apply(str)
              else
                str
              end
      end

      str
    end
  end
end
