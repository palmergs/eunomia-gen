module Eunomia
  module Segment
    # Common implementations of the value, multiplier, calc and generate methods
    module Common
      def value
        0
      end

      def multiplier
        1
      end

      def generate(request, alts: {}, functions: [])
        calc # update values for dynamic segments
        elem = Eunomia::Element.new(text, value: value, multiplier: multiplier)
        elem.substitute(request, alts: alts)
        elem.apply(request, functions: functions)
        elem
      end

      def calc; end
    end
  end
end
