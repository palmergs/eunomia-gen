# frozen_string_literal: true

RSpec.describe :metadata_examples do
  let(:json) do
    [
      {
        key: "city-name",
        functions: ["capitalize"],
        items: [
          "[city-founder][city-location]",
          "[city-feature][city-location]",
          "[city-location][city-location]"
        ]
      },
      {
        key: "city-founder",
        items: %w[knights kings queens earls],
        tags: %w[occupation:royal-person]
      },
      {
        key: "city-feature",
        items: [
          { segments: "oak", meta: { "feature" => "forest" } },
          { segments: "elm", meta: { "feature" => "forest" } },
          { segments: "pine", meta: { "feature" => "forest" } },
          { segments: "iron", meta: { "feature" => "mine", "resource" => "iron" } },
          { segments: "gold", meta: { "feature" => "mine", "resource" => "gold" } },
          { segments: "silver", meta: { "feature" => "mine", "resource" => "silver" } },
          { segments: "copper", meta: { "feature" => "mine", "resource" => "copper" } }
        ]
      },
      {
        key: "city-location",
        items: [
          { segments: "dale", meta: { "location" => "valley" } },
          { segments: "ridge", meta: { "location" => "mountain" } },
          { segments: "field", meta: { "location" => "plain" } },
          { segments: "port", meta: { "location" => "coast", "feature" => "harbor" } },
          { segments: "dam", meta: { "location" => "river", "feature" => "dam" } },
          { segments: "fall", meta: { "location" => "river", "feature" => "waterfall" } },
          { segments: "wood", meta: { "location" => "forest" } },
          { segments: "garden", meta: { "location" => "plain" } },
          { segments: "shore", meta: { "location" => "coast" } }
        ]
      }
    ]
  end

  it "can generate a city name with metadata about the location" do
    Eunomia.add(json)
    request = Eunomia::Request.new("city-name", unique: true)
    arr = []
    10.times do
      result = request.generate
      arr << [result.to_s, result.meta]
    end
    pp arr
  end
end
