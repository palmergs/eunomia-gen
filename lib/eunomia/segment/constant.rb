# frozen_string_literal: true

module Eunomia
  module Segment
    class Constant
      include Common

      SEPARATOR_MATCHER = /\p{Space}|\p{Punct}/

      attr_reader :text

      def initialize(text)
        @text = text
      end

      def generate(_request)
        calc # update values for dynamic segments
        Eunomia::Separator.new(text)
      end

      def self.build(scanner)
        str = scanner.scan(SEPARATOR_MATCHER)
        new(str) if str
      end
    end
  end
end
