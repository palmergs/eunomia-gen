require "spec_helper"

RSpec.describe Eunomia::Selector do
  it "should select an item" do
    Item = Struct.new(:weight)

    items = [Item.new(1), Item.new(2), Item.new(3)]
    s = Eunomia::Selector.new
    expect(s.select(items)).to be_a(Item)
  end
end
