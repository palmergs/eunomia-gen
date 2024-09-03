# frozen_string_literal: true

module Eunomia
  module Function
    class Capitalize
      def apply(arr)
        arr.map(&:capitalize)
      end
    end
  end
end
