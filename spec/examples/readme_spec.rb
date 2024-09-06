require "spec_helper"

RSpec.describe :readme_example do
  it "runs with the example from the README.md file" do
    data = [
      {
        key: "generator",
        items: [
          functions: %w[pluralize capitalize],
          segments: "[d4] [thing]"
        ]
      },
      {
        key: "thing",
        items: %w[apple banana cherry]
      }
    ]

    Eunomia.add(data)
    p Eunomia.generate("generator").to_s # => "3 Bananas"
  end
end
