# frozen_string_literal: true

require "strscan"

require_relative "segment/dice"
require_relative "segment/constant"
require_relative "segment/text"
require_relative "segment/number"
require_relative "segment/reference"

module Eunomia
  module Segment
    def self.build(str)
      ss = StringScanner.new(str)
      arr = []
      until ss.eos?
        rem = ss.rest_size

        seg = Eunomia::Segment::Constant.build(ss)
        arr << seg if seg

        seg = Eunomia::Segment::Dice.build(ss)
        arr << seg if seg

        seg = Eunomia::Segment::Number.build(ss)
        arr << seg if seg

        seg = Eunomia::Segment::Text.build(ss)
        arr << seg if seg

        seg = Eunomia::Segment::Reference.build(ss)
        arr << seg if seg

        raise "Infinite loop in scanner: #{ss.rest} (#{rem})" if ss.rest_size == rem
      end
      arr
    end
  end
end
