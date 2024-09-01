# frozen_string_literal: true

RSpec.describe Eunomia::Item do
  let(:hsh) do
    {
      weight: 1,
      value: 1,
      segments: "[2d6] angry badgers",
      alts: { "enhance" => { "angry" => "enraged" } },
      meta: { "meta1" => "value1" },
      functions: ["capitalize"],
      sep: " "
    }
  end

  let(:item) do
    Eunomia::Item.new(hsh)
  end

  it "can generate a result" do
    request = Eunomia::Request.new(:test)
    result = item.generate(request)
    pp result
    expect(result.to_s).to match(/[\d]+ Angry Badgers/)
    expect(result.multiplier).to be >= 2
    expect(result.base_value).to eq 1
    expect(result.value).to eq result.base_value * result.multiplier
  end
end
