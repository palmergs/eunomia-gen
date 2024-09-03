# frozen_string_literal: true

module Eunomia
  module Function
    class Downcase
      def apply(arr)
        arr.map(&:downcase)
      end
    end
  end
end
