RSpec.describe :example_card_generator do
  let(:json) do
    [
      {
        key: "card-suite",
        items: %w[heart clubs diamonds spades]
      },
      {
        key: "card-face",
        alts: { "2" => { "*" => "duece" } },
        items: [
          { segments: "ace", value: 1 },
          { segments: "2", value: 2 },
          { segments: "3", value: 3 },
          { segments: "4", value: 4 },
          { segments: "5", value: 5 },
          { segments: "6", value: 6 },
          { segments: "7", value: 7 },
          { segments: "8", value: 8 },
          { segments: "9", value: 9 },
          { segments: "10", value: 10 },
          { segments: "jack", value: 10 },
          { segments: "queen", value: 10 },
          { segments: "king", value: 10 }
        ]
      }
    ]
  end
end
