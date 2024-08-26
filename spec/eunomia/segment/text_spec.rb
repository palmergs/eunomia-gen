require "spec_helper"
require "strscan"

RSpec.describe Eunomia::Segment::Text do
  it "can be parsed" do
    ss = StringScanner.new("test")
    t = Eunomia::Segment::Text.build(ss)
    expect(t.text).to eq("test")
  end

  it "ignores numbers" do
    ss = StringScanner.new("1234")
    t = Eunomia::Segment::Text.build(ss)
    expect(t).to be_nil
  end

  it "ignores references" do
    ss = StringScanner.new("[3d5+4]")
    t = Eunomia::Segment::Text.build(ss)
    expect(t).to be_nil
  end
end
