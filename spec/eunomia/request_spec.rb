# frozen_string_literal: true

require "spec_helper"

RSpec.describe Eunomia::Request do
  let(:gen) do
    [
      {
        key: "thing",
        items: ["[one]", "[two]", "[tree]"]
      },
      {
        key: "one",
        items: [
          "apple",
          { segments: "banana", meta: { "one" => "tag", "tag" => "any" } },
          "cherry"
        ]
      },
      {
        key: "two",
        items: [
          "dog",
          "cat",
          { segments: "bird", meta: { "two" => "tag", "tag" => "any" } }
        ]
      },
      { key: "tree",
        items: [
          { segments: "oak", meta: { "three" => "tag", "tag" => "any" } },
          "elm",
          "maple"
        ] }
    ]
  end

  it "has available filters" do
    Eunomia.add(gen)
    tmp = Eunomia.lookup("thing")
    pp tmp.filters
  end

  it "can filter through nested generators" do
    Eunomia.add(gen)
    req = described_class.new("thing", filters: ["one:tag"])
    val = req.generate
    expect(val.to_s).to eq("banana")
    expect(val.meta["one"]).to eq(["tag"])
    expect(val.meta["tag"]).to eq(["any"])
  end

  it "can filter through a tag that is in multiple generators" do
    Eunomia.add(gen)
    req = described_class.new("thing", filters: ["tag:any"])
    val = req.generate
    expect(%w[banana bird oak].include?(val.to_s)).to be true
    expect(val.meta["tag"]).to eq(["any"])
  end
end
