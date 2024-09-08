# frozen_string_literal: true

module Eunomia
  module Function
    # Titleize capitalizes each string in the array unless it's a word that
    # is not normally capitalized in a title.
    class Titleize
      SKIP_WORDS = Set.new(%w[a an and as at but by for if in of on or the to v via vs])

      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          idx = 0
          len = arr.length
          while idx < len
            arr[idx] = arr[idx].capitalize if capitalize?(arr[idx], idx, len)
            idx += 1
          end
          arr
        end
      end

      def capitalize?(str, idx, len)
        idx.zero? || idx == len - 1 || !SKIP_WORDS.include?(str.downcase)
      end
    end
  end
end
