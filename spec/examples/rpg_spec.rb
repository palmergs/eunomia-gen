# frozen_string_literal: true

RSpec.describe :example_rpg_attributes do
  let(:json) do
    [
      {
        key: "attributes",
        gen: "sequence",
        items: [
          "[attribute-value] STR",
          " ",
          "[attribute-value] CON",
          " ",
          "[attribute-value] DEX",
          " ",
          "[attribute-value] WIS",
          " ",
          "[attribute-value] INT",
          " ",
          "[attribute-value] CHR"
        ]
      },
      {
        key: "attribute-value",
        rng: "3d6",
        items: [
          { segments: "3 (-3)", value: 3, weight: 1, meta: { bonus: -3 } },
          { segments: "4 (-2)", value: 4, weight: 1, meta: { bonus: -2 } },
          { segments: "5 (-2)", value: 5, weight: 1, meta: { bonus: -2 } },
          { segments: "6 (-1)", value: 6, weight: 1, meta: { bonus: -1 } },
          { segments: "7 (-1)", value: 7, weight: 1, meta: { bonus: -1 } },
          { segments: "8 (-1)", value: 8, weight: 1, meta: { bonus: -1 } },
          { segments: "9", value: 9, weight: 1, meta: { bonus: 0 } },
          { segments: "10", value: 10, weight: 1, meta: { bonus: 0 } },
          { segments: "11", value: 11, weight: 1, meta: { bonus: 0 } },
          { segments: "12", value: 12, weight: 1, meta: { bonus: 0 } },
          { segments: "13 (+1)", value: 13, weight: 1, meta: { bonus: 1 } },
          { segments: "14 (+1)", value: 14, weight: 1, meta: { bonus: 1 } },
          { segments: "15 (+1)", value: 15, weight: 1, meta: { bonus: 1 } },
          { segments: "16 (+2)", value: 16, weight: 1, meta: { bonus: 2 } },
          { segments: "17 (+2)", value: 17, weight: 1, meta: { bonus: 2 } },
          { segments: "18 (+3)", value: 18, weight: 1, meta: { bonus: 3 } }
        ]
      }
    ]
  end

  it "can generate an attribute list" do
    Eunomia.add(json)
    request = Eunomia::Request.new("attributes")
    result = request.generate
    pp [result.to_s, result.value]
    pp result
  end
end
