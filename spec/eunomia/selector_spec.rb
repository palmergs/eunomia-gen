# frozen_string_literal: true

require "spec_helper"

RSpec.describe Eunomia::Selector do
  it "should select an item" do
    tmp = Struct.new(:weight)

    items = [tmp.new(1), tmp.new(2), tmp.new(3)]
    s = Eunomia::Selector.new
    expect(s.select(items)).to be_a(tmp)
  end
end
