require "strscan"

require_relative "segment/dice"
require_relative "segment/constant"
require_relative "segment/text"
require_relative "segment/number"
require_relative "segment/reference"

module Segment
  def self.build str
    print str
    ss = StringScanner.new(str)
    arr = []
    while !ss.eos?
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

      print "#{ ss.rest } (#{ ss.rest_size })\n"
    end
    arr
  end
end
