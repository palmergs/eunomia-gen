module Eunomia
  class Element
    attr_reader :orig, :str, :value, :multiplier, :meta, :children

    def initialize(str, value: 0, multiplier: 1, children: nil)
      @orig = str
      @str = str
      @value = value
      @multiplier = multiplier
      @meta = {}
      @children = children
    end

    def children?
      !children.nil? && !children.empty?
    end

    def to_s
      str
    end

    def to_h
      if children?
        { orig:, str:, value:, multiplier:, children: children.map(&:to_h) }
      else
        { orig:, str:, value:, multiplier: }
      end
    end
  end
end
