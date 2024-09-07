# frozen_string_literal: true

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

      def generate(_request)
        calc # update values for dynamic segments
        Eunomia::Element.new(text, value: value, multiplier: multiplier)
      end

      def calc; end
    end
  end
end
