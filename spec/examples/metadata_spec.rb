# frozen_string_literal: true

RSpec.describe "Examples with metadata", type: :feature do
  let(:json) do
    [
      {
        key: "city-name",
        functions: ["capitalize"],
        items: [
          { segments: "[base-city-name]", weight: 10 },
          { segments: "fort [base-city-name]", meta: { "feature" => "fort" } },
          { segments: "[descriptor] [base-city-name]" }
        ]
      },
      {
        key: "descriptor",
        items: %w[north south east west upper lower new]
      },
      {
        key: "base-city-name",
        items: [
          { segments: "[city-founder][city-location]" },
          { segments: "[city-founder][city-size]" },
          { segments: "[city-feature][city-location]" },
          { segments: "[city-location][city-size]" },
          { segments: "[city-feature][city-location]" },
          { segments: "[city-location][city-size]" }

        ]
      },
      {
        key: "city-founder",
        items: [
          { segments: "knights", meta: { "founder" => "soldier" } },
          { segments: "kings", meta: { "founder" => %w[royalty male] } },
          { segments: "queens", meta: { "founder" => %w[royalty female] } },
          { segments: "earls", meta: { "founder" => "nobility" } },
          { segments: "dukes", meta: { "founder" => "nobility" } },
          { segments: "wardens", meta: { "founder" => "soldier" } }
        ]
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
          { segments: "copper", meta: { "feature" => "mine", "resource" => "copper" } },
          { segments: "guards", meta: { "feature" => "fort", "founder" => "soldier" } },
          "green",
          "white",
          "black",
          "grey",
          "red"
        ]
      },
      {
        key: "city-size",
        items: %w[burg borough town ville]
      },
      {
        key: "city-location",
        items: [
          { segments: "dale", meta: { "location" => "valley" } },
          { segments: "bridge", meta: { "location" => "river" } },
          { segments: "ridge", meta: { "location" => "mountain" } },
          { segments: "field", meta: { "location" => "plain" } },
          { segments: "meadow", meta: { "location" => "plain" } },
          { segments: "yard", meta: { "location" => "plain" } },
          { segments: "port", meta: { "location" => "coast", "feature" => "harbor" } },
          { segments: "dam", meta: { "location" => "river", "feature" => "dam" } },
          { segments: "fall", meta: { "location" => "river", "feature" => "waterfall" } },
          { segments: "wood", meta: { "location" => "forest" } },
          { segments: "park", meta: { "location" => "forest" } },
          { segments: "grove", meta: { "location" => "forest" } },
          { segments: "brake", meta: { "location" => "forest" } },
          { segments: "wild", meta: { "location" => "forest" } },
          { segments: "hedge", meta: { "location" => "forest" } },
          { segments: "garden", meta: { "location" => "plain" } },
          { segments: "shore", meta: { "location" => "coast" } },
          { segments: "guard", meta: { "feature" => "fort" } }
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
    expect(arr.size).to eq(10)
    pp arr
  end

  it "can generate a city founded by a knight" do
    Eunomia.add(json)
    request = Eunomia::Request.new("city-name", unique: true, filters: "founder:soldier")
    result = request.generate
    pp result.to_h
    expect(result.meta["founder"]).to include("soldier")
  end
end
