module Eunomia
  module Function
    class Quote
      def apply str
        return '' if str.blank?

        "“#{ str.strip }”"
      end
    end
  end
end

