# frozen_string_literal: true

module Eunomia
  module Function
    # Capitalize each string in the array
    class Capitalize
      def apply(arr)
        to_proc.call(arr)
      end

      def to_proc
        proc do |arr|
          arr.map(&:capitalize)
        end
      end
    end
  end
end
