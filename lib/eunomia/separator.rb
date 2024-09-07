module Eunomia
  class Separator
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def to_s
      text
    end

    def to_h
      { orig: text, text: text }
    end
  end
end
