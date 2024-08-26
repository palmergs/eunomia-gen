# frozen_string_literal: true

require "spec_helper"

RSpec.describe Eunomia::Segment::Dice do
  it "can calculate values" do
    d = Eunomia::Segment::Dice.new(3, 6, "+", 3)
    expect(d.calc).to be >= 6
  end

  it "can build from a string" do
    d = Eunomia::Segment::Dice.parse(":d4")
    expect(d).to_not be_nil
    expect(d.count).to eq(1)
    expect(d.range).to eq(4)
    expect(d.op).to eq("+")
    expect(d.constant).to eq(0)
  end
end
