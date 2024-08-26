RSpec.describe Eunomia::Segment::Constant do
  it "can be parsed" do
    s1 = Eunomia::Segment::Constant.parse(" ")
    s2 = Eunomia::Segment::Constant.parse(":ws")
    s3 = Eunomia::Segment::Constant.parse(":space")
    expect(s1).to eq(s3)
    expect(s2).to eq(s3)
    expect(s3.str).to eq(" ")
  end
end
