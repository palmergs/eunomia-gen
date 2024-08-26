module Eunomia
  module Segment
    class Text
      TEXT_MATCHER = /\p{Alpha}\p{Alnum}*/

      attr_reader :text, :value

      def initialize(text)
        @text = text
        @value = Eunomia::Value.new(text)
      end

      def self.build(scanner)
        str = scanner.scan(TEXT_MATCHER)
        new(str) if str
      end
    end
  end
end
