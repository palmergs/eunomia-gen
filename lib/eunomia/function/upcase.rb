# frozen_string_literal: true

module Eunomia
  module Function
    class Upcase
      def apply(arr)
        arr.map(&:upcase)
      end
    end
  end
end
