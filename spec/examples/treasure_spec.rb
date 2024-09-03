RSpec.describe :example_treasure do
  let(:json) do
    [
      {
        key: "treasure-container",
        items: [
          "a small chest containing [random-coin] and [random-gem]",
          "a linen sack containing [random-coin]",
          "a leather pouch containg [random-coin]",
          "a wooden box containing [random-coin] and [random-gem]",
          "a stack of [random-coin]",
          "a cloth sack containing [random-coin], [random-gem], and [random-art]"
        ]
      },
      {
        key: "random-coin",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %([3d10x10] copper coin), weight: 8, value: 1 },
          { segments: %([3d8x10] silver coin), weight: 4, value: 10 },
          { segments: %([2d6x10] electrum coin), weight: 3, value: 100 },
          { segments: %([2d4x4] gold coin), weight: 2, value: 1000 },
          { segments: %([2d4] platinum coin), weight: 1, value: 10_000 }
        ]
      },
      {
        key: "random-gem",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %([d10] small topaz), weight: 4, value: 100 },
          { segments: %([d8] small emerald), weight: 3, value: 900 },
          { segments: %([d6] small sapphire), weight: 2, value: 800 },
          { segments: %([d4] small ruby), weight: 1, value: 1000 },
          { segments: %([d4] small diamond), weight: 1, value: 10_000 }
        ]
      },
      {
        key: "random-art",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %(a small silver mirror), weight: 4, value: 80 },
          { segments: %([2d4-1] silver spoon), weight: 3, value: 40 }
        ]
      }
    ]
  end

  it "can generate a treasure description" do
    Eunomia::STORE.add(json)
    request = Eunomia::Request.new("treasure-container")
    arr = []
    10.times do
      result = request.generate
      arr << [result.to_s, result.value]
    end
    pp arr
  end
end
