# frozen_string_literal: true

RSpec.describe Eunomia::Generator do
  let(:tree_feminine) { %w[holly hazel willow aspen juniper magnolia olive] }
  let(:tree_masculine) { %w[larch ash rowan laurel linden filbert hawthorn] }
  let(:tree_other) { %w[oak pine ceder elm chesnut birch] }

  let(:name_generator) do
    {
      key: "first-name",
      items: [{ segments: "[tree]" }]
    }
  end

  let(:json) do
    arr = [{ key: "tree", items: [] }]
    tree_feminine.each do |name|
      arr[0][:items] << { segments: name, tags: "name:feminine" }
    end
    tree_masculine.each do |name|
      arr[0][:items] << { segments: name, tags: "name:masculine" }
    end
    tree_other.each do |name|
      arr[0][:items] << { segments: name }
    end

    arr << name_generator
    arr
  end

  it "can generate a name for a person with attributes" do
    pp json
    Eunomia.add(json)

    request = Eunomia::Request.new("first-name", tags: ["name:masculine"])
    5.times do
      gen = request.generate
      expect(gen.meta["name"]).to eq(["masculine"])
      name = gen.to_s
      p name
      expect(tree_masculine).to include(name.downcase)
    end

    request = Eunomia::Request.new("first-name", tags: ["name:feminine"])
    5.times do
      gen = request.generate
      expect(gen.meta["name"]).to eq(["feminine"])
      name = gen.to_s
      p name
      expect(tree_feminine).to include(name.downcase)
    end
  end
end
