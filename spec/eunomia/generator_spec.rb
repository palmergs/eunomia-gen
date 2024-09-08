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
    Eunomia.add(arr)
    request = Eunomia::Request.new("gen-3")
    result = request.generate
    expect(result.to_s).to eq("a")
  end

  it "can generate a recursive result" do
    Eunomia.add(arr)
    request = Eunomia::Request.new("gen-1")
    result = request.generate
    expect(result.to_s).to match(/^a+$/)
  end

  it "can apply a pre-defined function" do
    Eunomia.add(arr)
    request = Eunomia::Request.new("gen-1", functions: ["capitalize"])
    result = request.generate
    expect(result.to_s).to match(/^Aa*$/)
  end

  it "can apply a custom function" do
    Eunomia.add(arr)
    Eunomia.add_function(:rot13, proc { |arr| arr.map { |str| str.tr("A-Za-z", "N-ZA-Mn-za-m") } })
    request = Eunomia::Request.new("gen-1", functions: ["rot13"])
    result = request.generate
    expect(result.to_s).to match(/^n+$/)
  end
end
