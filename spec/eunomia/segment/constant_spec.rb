# frozen_string_literal: true

require "spec_helper"
require "strscan"

RSpec.describe Eunomia::Segment::Constant do
  it "can be parsed" do
    ss = StringScanner.new(" ")
    s1 = Eunomia::Segment::Constant.build(ss)

    ss = StringScanner.new(":ws")
    s2 = Eunomia::Segment::Constant.build(ss)

    ss = StringScanner.new(":space")
    s3 = Eunomia::Segment::Constant.build(ss)
    expect(s1).to eq(s3)
    expect(s2).to eq(s3)
    expect(s3.text).to eq(" ")
  end
end
