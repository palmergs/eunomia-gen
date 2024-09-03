# frozen_string_literal: true

module Eunomia
  module Function
    class Titleize
      SKIP_WORDS = Set.new(%w[a an and as at but by for if in of on or the to v via vs])

      def apply(arr)
        idx = 0
        len = arr.length
        while idx < len
          arr[idx] = arr[idx].capitalize if capitalize?(arr[idx], idx, len)
          idx += 1
        end
        arr
      end

      def capitalize?(str, idx, len)
        idx.zero? || idx == len - 1 || !SKIP_WORDS.include?(str.downcase)
      end
    end
  end
end
