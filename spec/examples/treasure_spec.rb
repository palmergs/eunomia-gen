# frozen_string_literal: true

RSpec.describe :example_treasure do
  let(:json) do
    [
      {
        key: "treasure-container",
        items: [
          {
            segments: %("a small chest containing [random-coin] and [random-gem]"),
            meta: { "item" => "chest-small-wooden" }
          },
          "a linen sack containing [random-coin-stack]",
          "a leather pouch containg [random-coin-stack]",
          "a wooden box containing [random-coin-stack] and [random-gem]",
          "a stack of [random-coin-stack]",
          "a cloth sack containing [random-coin-stack], [random-gem], and [random-art]"
        ]
      },
      {
        key: "random-coin-stack",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %([3d10x10] [random-coin]), weight: 1 },
          { segments: %([3d8x10] [random-coin]), weight: 1 },
          { segments: %([2d6x10] [random-coin]), weight: 2 },
          { segments: %([2d4x4] [random-coin]), weight: 4 },
          { segments: %([2d4] [random-coin]), weight: 8 }
        ]
      },
      {
        key: "random-coin",
        items: [
          { segments: "copper coin", weight: 8, value: 1, meta: { "item" => "coin-copper" } },
          { segments: "silver coin", weight: 4, value: 10, meta: { "item" => "coin-silver" } },
          { segments: "electrum coin", weight: 3, value: 100, meta: { "item" => "coin-electrum" } },
          { segments: "gold coin", weight: 2, value: 1000, meta: { "item" => "coin-gold" } },
          { segments: "platinum coin", weight: 1, value: 10_000, meta: { "item" => "coin-platinum" } }
        ]
      },
      {
        key: "random-gem",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %([d10] small topaz), weight: 4, value: 100, meta: { "item" => "gem-topaz" } },
          { segments: %([d8] small emerald), weight: 3, value: 900, meta: { "item" => "gem-emerald" } },
          { segments: %([d6] small sapphire), weight: 2, value: 800, meta: { "item" => "gem-sapphire" } },
          { segments: %([d4] small ruby), weight: 1, value: 1000, meta: { "item" => "gem-ruby" } },
          { segments: %([d4] small diamond), weight: 1, value: 10_000, meta: { "item" => "gem-diamond" } }
        ]
      },
      {
        key: "random-art",
        alts: { "1" => { "en" => "a" }, "2" => { "en" => "a pair of" } },
        functions: ["pluralize"],
        items: [
          { segments: %(a small silver mirror), weight: 4, value: 80, meta: { "item" => "art-silver-mirror" } },
          { segments: %([2d4-1] silver spoon), weight: 3, value: 40, meta: { "item" => "art-silver-spoon" } }
        ]
      }
    ]
  end

  it "can generate a treasure description" do
    Eunomia.add(json)
    request = Eunomia::Request.new("treasure-container")
    pp request.generate.to_h
  end
end
