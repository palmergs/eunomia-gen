# frozen_string_literal: true

RSpec.describe Eunomia::Segment do
  it "can build segments from consecutive references" do
    arr = Eunomia::Segment.build("[test-one][test-two]")
    expect(arr.count).to eq(2)
    expect(arr[0]).to be_a(Eunomia::Segment::Reference)
    expect(arr[0].key).to eq("test-one")
    expect(arr[0].version).to eq(0)
    expect(arr[1]).to be_a(Eunomia::Segment::Reference)
    expect(arr[1].key).to eq("test-two")
    expect(arr[1].version).to eq(0)
  end
end
