# frozen_string_literal: true

module Eunomia
  module Function
    # Upcase each string in the array
    class Upcase
      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          arr.map(&:upcase)
        end
      end
    end
  end
end
