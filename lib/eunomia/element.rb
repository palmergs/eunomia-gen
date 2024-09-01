module Eunomia
  class Element
    attr_reader :orig, :str, :value, :multiplier, :children

    def initialize(str, value: 0, multiplier: 1, children: nil)
      @orig = str
      @str = str
      @value = value
      @multiplier = multiplier
      @children = children
    end

    def children?
      !children.empty?
    end

    def substitute(request, alts: {})
      @str = request.alts[str] if request.alts.key(str)
      @str = alts[request.alt_key][str] if request.alt_key?
    end

    def apply(request, functions: [])
      all_functions = request.functions + functions
      @str = Eunomia::Function.apply(str, all_functions)
    end

    def to_s
      str
    end

    def to_hsh
      { orig:, str:, value:, multiplier:, children: children.map(&:to_hsh) }
    end
  end
end
