module Eunomia
  module Function
    class Titleize
      SKIP_WORDS = Set.new(%w[a an and as at but by for if in of on or the to v via vs])

      def apply str
        arr = str.split(/\s+/)
        idx = 0
        len = arr.length
        while idx < len
          if idx == 0 || idx == len - 1 || !SKIP_WORDS.include?(arr[idx].downcase)
            arr[idx] = arr[idx].capitalize
          end
          idx += 1
        end
        arr.join(' ')
      end
    end
  end
end
