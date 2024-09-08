# frozen_string_literal: true

RSpec.describe Eunomia::Generator do
  let(:tree_feminine) { %w[holly hazel willow aspen juniper magnolia olive] }
  let(:tree_masculine) { %w[larch ash rowan laurel linden filbert hawthorn] }

  let(:name_generator) do
    {
      key: "first-name",
      items: [{ segments: "[tree]", tags: %w[attribute:feminine attribute:masculine] }]
    }
  end

  let(:json) do
    arr = [{ key: "tree", items: [] }]
    tree_feminine.each do |name|
      arr[0][:items] << { segments: name, tags: "attribute:feminine" }
    end
    tree_masculine.each do |name|
      arr[0][:items] << { segments: name, tags: "attribute:masculine" }
    end
    arr << name_generator
    arr
  end

  it "can generate a name for a person with attributes" do
    Eunomia.add(json)

    request = Eunomia::Request.new("first-name", tags: ["attribute:masculine"])
    m = []
    5.times do
      name = request.generate.to_s
      expect(tree_masculine).to include(name.downcase)
      m << name
    end

    request = Eunomia::Request.new("first-name", tags: ["attribute:feminine"])
    f = []
    5.times do
      name = request.generate.to_s
      expect(tree_feminine).to include(name.downcase)
      f << name
    end

    pp m + f
  end
end
