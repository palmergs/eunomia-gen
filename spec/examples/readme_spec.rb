require "spec_helper"

RSpec.describe :readme_example do
  it "runs the usage example from the README.md file" do
    data = [
      {
        key: "random-fruit",
        items: [
          functions: %w[pluralize capitalize],
          segments: "[d4] [fruit]"
        ]
      },
      {
        key: "fruit",
        items: %w[apple banana orange pear kiwi]
      }
    ]

    Eunomia.add(data)
    p Eunomia.generate("random-fruit").to_s # => "3 Bananas"
  end

  it "runs the translations example from the README.md file" do
    data = [
      { key: "fruit", items: %w[apple banana orange pear kiwi], alts: { "apple" => { "es" => "manzana" } } }
    ]

    Eunomia.add(data)
    request = Eunomia::Request.new("fruit", alt_key: "es", unique: true, alts: { "kiwi" => "a small flightless bird" })
    arr = []
    5.times { arr << request.generate.to_s }
    p arr.join(", ") # => "manzana, banana, orange, pear, a small flightless bird"
  end

  it "runs the custom function example from the README.md file" do
    data = [
      { key: "fruit", items: %w[apple banana orange pear kiwi] },
      { key: "random-fruit", items: [{ segments: "[d4] [fruit]" }] }
    ]

    Eunomia.add(data)
    Eunomia.add_function(:reverse, proc { |arr| arr.map(&:reverse) })
    request = Eunomia::Request.new("random-fruit", functions: %w[pluralize reverse])
    p request.generate.to_s # => "3 sananab"

    request = Eunomia::Request.new("random-fruit", functions: %w[reverse pluralize])
    p request.generate.to_s # => "3 ikiks"
  end
end
