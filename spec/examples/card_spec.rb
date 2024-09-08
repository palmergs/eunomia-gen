# frozen_string_literal: true

RSpec.describe :example_card_generator do
  let(:json) do
    [
      {
        key: "card-suite",
        items: %w[hearts clubs diamonds spades]
      },
      {
        key: "card-face",
        alts: {
          "1" => { "*" => "ace" },
          "2" => { "*" => "duece", "es" => "dos" },
          "3" => { "*" => "three", "es" => "tres" },
          "4" => { "*" => "four", "es" => "quatro" },
          "5" => { "*" => "five", "es" => "cinco" },
          "6" => { "*" => "six" },
          "7" => { "*" => "seven" },
          "8" => { "*" => "eight" },
          "9" => { "*" => "nine" },
          "10" => { "*" => "ten" },
          "11" => { "*" => "jack" },
          "12" => { "*" => "queen" },
          "13" => { "*" => "king" }
        },
        items: [
          { segments: "1", value: 1 },
          { segments: "2", value: 2 },
          { segments: "3", value: 3 },
          { segments: "4", value: 4 },
          { segments: "5", value: 5 },
          { segments: "6", value: 6 },
          { segments: "7", value: 7 },
          { segments: "8", value: 8 },
          { segments: "9", value: 9 },
          { segments: "10", value: 10 },
          { segments: "11", value: 10 },
          { segments: "12", value: 10 },
          { segments: "13", value: 10 }
        ]
      },
      {
        key: "playing-card",
        functions: ["titleize"],
        items: [
          "a [card-face] of [card-suite]"
        ]
      }
    ]
  end

  it "can generate a card" do
    Eunomia.add(json)
    request = Eunomia::Request.new(
      "playing-card",
      alts: {
        "hearts" => "hearts",
        "clubs" => "clover",
        "spades" => "pikes",
        "diamonds" => "tiles"
      },
      alt_key: "es"
    )
    arr = []
    10.times do
      result = request.generate
      arr << [result.to_s, result.value]
    end
    pp arr
  end
end
