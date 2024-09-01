# frozen_string_literal: true

require "strscan"

require_relative "segment/common"
require_relative "segment/dice"
require_relative "segment/constant"
require_relative "segment/text"
require_relative "segment/number"
require_relative "segment/reference"

module Eunomia
  # Segment represents a single token in an `Item`.
  module Segment
    def self.build(str)
      ss = StringScanner.new(str)
      arr = []
      until ss.eos?
        seg = Eunomia::Segment::Dice.build(ss) || Eunomia::Segment::Reference.build(ss) || Eunomia::Segment::Number.build(ss) || Eunomia::Segment::Constant.build(ss) || Eunomia::Segment::Text.build(ss)
        raise "Unable to parse #{ss.rest} (#{ss.rest_size})" unless seg

        arr << seg
      end
      arr
    end
  end
end
