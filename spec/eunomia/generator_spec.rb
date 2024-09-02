RSpec.describe Eunomia::Generator do
  let(:arr) do
    [
      {
        key: "gen-1",
        items: %w[[gen-2]]
      },
      {
        key: "gen-2",
        items: %w[a[gen-3] [gen-1]]
      },
      {
        key: "gen-3",
        items: %w[a]
      }
    ]
  end

  it "can generate a non-recursive result" do
    Eunomia::STORE.add(arr)
    request = Eunomia::Request.new("gen-3")
    result = request.generate
    expect(result.to_s).to eq("a")
  end

  it "can generate a recursive result" do
    Eunomia::STORE.add(arr)
    request = Eunomia::Request.new("gen-1")
    result = request.generate
    expect(result.to_s).to match(/^a+$/)
  end
end
