# frozen_string_literal: true

module Eunomia
  module Segment
    class Text
      TEXT_MATCHER = /\p{Alpha}\p{Alnum}*/

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def generate request, response
        response.append(:text, text)
      end

      def self.build(scanner)
        str = scanner.scan(TEXT_MATCHER)
        new(str) if str
      end
    end
  end
end
