# frozen_string_literal: true

module Eunomia
  class Result
    attr_reader :key, :display, :elements, :multiplier, :base_value, :meta

    def initialize(key, value: 0, multiplier: 1)
      @key = key
      @base_value = value
      @multiplier = multiplier
      @elements = []
      @meta = Hash.new {|h,k| h[k] = Set.new}
      @display = ""
    end

    def append(obj)
      if obj.is_a?(Element)
        append_element(obj)
      elsif obj.is_a?(Result)
        append_result(obj)
      elsif obj.is_a?(Separator)
        append_separator(obj)
      end
    end

    def append_element(element)
      @elements << element
      @display += element.to_s
      @multiplier *= element.multiplier unless element.multiplier.nil?
      @base_value += element.value unless element.value.nil?
      merge_meta(element.meta)
      self
    end

    def append_separator(separator)
      @display += separator.to_s
      self
    end

    def append_result(result)
      element = Element.new(result.to_s, value: result.value, multiplier: result.multiplier, children: result.elements)
      @elements << element
      @display += element.to_s
      @base_value += element.value
      merge_meta(result.meta)
      self
    end

    def merge_meta(m)
      return unless m

      m.each do |k, v|
        v = [v] unless v.is_a?(Enumerable)
        @meta[k] = Set.new(@meta[k] + v).to_a
      end
    end

    def apply_translations(alts, locale: nil)
      arr = to_s.split(/\s+/)
      arr = arr.map do |segment|
        hsh = alts[segment]
        hsh = hsh.is_a?(Hash) ? hsh[locale] || hsh['*'] || segment : hsh || segment
      end
    end

    def apply_functions(arr, functions)
      Eunomia.apply(arr, functions)
    end

    def apply(alts, functions, locale: nil)
      arr = apply_translations(alts, locale: locale)
      arr = apply_functions(arr, functions)

      @display = arr.join(' ')
      self
    end

    def value
      base_value * multiplier
    end

    def to_s
      @display
    end

    def to_h
      { display:, key:, value:, multiplier:, meta:, elements: elements&.map(&:to_h) }
    end
  end
end
