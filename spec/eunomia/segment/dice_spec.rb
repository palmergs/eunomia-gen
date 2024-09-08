# frozen_string_literal: true

require "spec_helper"
require "strscan"

RSpec.describe Eunomia::Segment::Dice do
  it "can calculate values" do
    d = Eunomia::Segment::Dice.new(3, 6, "+", 3)
    expect(d.calc).to be >= 6
  end

  it "can build from a string" do
    ss = StringScanner.new("[d4]")
    d = Eunomia::Segment::Dice.build(ss)
    expect(d).to_not be_nil
    expect(d.count).to eq(1)
    expect(d.range).to eq(4)
    expect(d.op).to eq("+")
    expect(d.constant).to eq(0)
    expect(d.text).to match(/[0-4]/)

    sum = 0.0
    100.times { sum += d.calc }
    expect(sum / 100.0).to be > 2.0
    expect(sum / 100.0).to be < 3.0
  end

  it "can build with an operator and a constant" do
    tests = [
      ["[3d6+3]", 3, 6, "+", 3],
      ["[d6-3]", 1, 6, "-", 3],
      ["[6d6x3]", 6, 6, "x", 3],
      ["[2d6/3]", 2, 6, "/", 3]
    ]
    tests.each do |test|
      ss = StringScanner.new(test[0])
      d = Eunomia::Segment::Dice.build(ss)
      expect(d).to_not be_nil
      expect(d.count).to eq(test[1])
      expect(d.range).to eq(test[2])
      expect(d.op).to eq(test[3])
      expect(d.constant).to eq(test[4])
    end
  end
end
