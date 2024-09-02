# frozen_string_literal: true

module Eunomia
  class Result
    attr_reader :source, :elements, :multiplier, :base_value

    def initialize(source, value: 0, multiplier: 1)
      @source = source
      @base_value = value
      @multiplier = multiplier
      @elements = []
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
    end

    def append_result(result)
      element = Element.new(result.to_s, value: result.value, multiplier: result.multiplier, children: result.elements)
      @elements << element
      @display += element.to_s
    end

    def apply(request, generator, item)
      arr = to_s.split(/\s+/)
      arr.map! do |segment|
        segment = request.alt_for(segment)
        segment = item.alt_for(request.alt_key, segment)
        segment = generator.alt_for(request.alt_key, segment)
        segment = Eunomia::Function.apply(segment, request.functions)
        segment = Eunomia::Function.apply(segment, generator.functions)
        segment = Eunomia::Function.apply(segment, item.functions)
        segment
      end

      @display = arr.join
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
