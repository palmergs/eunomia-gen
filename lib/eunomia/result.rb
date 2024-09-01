module Eunomia
  class Result
    attr_reader :source, :elements, :multiplier, :base_value

    def initialize(source, value: 0, multiplier: 1)
      @source = source
      @base_value = value
      @multiplier = multiplier
      @elements = []
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
      @multiplier *= element.multiplier unless element.multiplier.nil?
      @base_value += element.value unless element.value.nil?
    end

    def append_result(result)
      element = Element.new(result.to_s, value: result.value, multiplier: result.multiplier, children: result.elements)
      @elements << element
    end

    def value
      base_value * multiplier
    end

    def to_s
      @elements.map(&:to_s).join
    end
  end
end
