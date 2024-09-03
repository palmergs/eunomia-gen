# frozen_string_literal: true

module Eunomia
  module Function
    class Quote
      def apply(arr)
        arr[0] = "\"#{arr[0]}"
        arr[-1] = "#{arr[-1]}\""
        arr
      end
    end
  end
end
