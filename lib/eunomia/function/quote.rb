# frozen_string_literal: true

module Eunomia
  module Function
    # Quote add a quote to the beginning of the first string and the end of the last string
    class Quote
      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          arr[0] = "\"#{arr[0]}"
          arr[-1] = "#{arr[-1]}\""
          arr
        end
      end
    end
  end
end
