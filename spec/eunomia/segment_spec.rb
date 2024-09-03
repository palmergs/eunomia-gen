# frozen_string_literal: true

RSpec.describe Eunomia::Segment do
  it "can build segments from consecutive references" do
    arr = Eunomia::Segment.build("[test-one][test-two:with-label]")
    expect(arr.count).to eq(2)
    expect(arr[0]).to be_a(Eunomia::Segment::Reference)
    expect(arr[0].key).to eq("test-one")
    expect(arr[0].label).to be_nil
    expect(arr[1]).to be_a(Eunomia::Segment::Reference)
    expect(arr[1].key).to eq("test-two")
    expect(arr[1].label).to eq("with-label")
  end
end
