# frozen_string_literal: true

module Eunomia
  class Result
    attr_reader :source, :elements, :multiplier, :base_value, :meta

    def initialize(source, value: 0, multiplier: 1)
      @source = source
      @base_value = value
      @multiplier = multiplier
      @elements = []
      @meta = {}
      @display = ""
    end

    def append(obj)
      if obj.is_a?(Element)
        append_element(obj)
      elsif obj.is_a?(Result)
        append_result(obj)
      end
    end

    def append_element(element)
      @elements << element
      @display += element.to_s
      @multiplier *= element.multiplier unless element.multiplier.nil?
      @base_value += element.value unless element.value.nil?
      @meta.merge!(element.meta)
      self
    end

    def append_result(result)
      element = Element.new(result.to_s, value: result.value, multiplier: result.multiplier, children: result.elements)
      @elements << element
      @display += element.to_s
      @base_value += element.value
      @meta.merge!(result.meta)
      self
    end

    def apply(alts, functions, locale: nil)
      arr = to_s.split(/\s+/)
      arr = arr.map do |segment|
        ret = alts[segment]
        ret = ret.is_a?(Hash) ? ret[locale] || ret['*'] || segment : ret || segment
      end
      arr = Eunomia::Function.apply(arr, functions)

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
      { source:, value:, multiplier:, elements: elements.map(&:to_h) }
    end
  end
end
