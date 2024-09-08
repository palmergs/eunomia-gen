# frozen_string_literal: true

module Eunomia
  module Function
    # Downcase each string in the array
    class Downcase
      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          arr.map(&:downcase)
        end
      end
    end
  end
end
