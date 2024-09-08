# frozen_string_literal: true

require "spec_helper"

RSpec.describe Eunomia::Selector do
  let(:weighted) { Struct.new(:weight, :text) }

  it "should select an item" do
    items = [weighted.new(1, "one"), weighted.new(2, "two"), weighted.new(3, "three")]
    s = Eunomia::Selector.new
    expect(s.select(items)).to be_a(weighted)
  end

  it "can select an item using dice notation" do
    items = [
      weighted.new(1, "very rare"),
      weighted.new(1, "rare"),
      weighted.new(1, "odd"),
      weighted.new(1, "uncommon"),
      weighted.new(1, "common"),
      weighted.new(1, "common"),
      weighted.new(1, "uncommon"),
      weighted.new(1, "odd"),
      weighted.new(1, "rare"),
      weighted.new(1, "very rare")
    ]
    hst = Hash.new { |h, k| h[k] = 0 }
    sel = Eunomia::Selector.new("3d4")
    1000.times { hst[sel.select(items).text] += 1 }
    pp hst
    expect(hst["very rare"]).to be > 0
    expect(hst["rare"]).to be > hst["very rare"]
    expect(hst["odd"]).to be > hst["rare"]
    expect(hst["uncommon"]).to be > hst["odd"]
    expect(hst["common"]).to be > hst["uncommon"]
  end
end
