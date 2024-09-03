# frozen_string_literal: true

require "spec_helper"

RSpec.describe :example_dwarf_names do
  let(:json) do
    [
      {
        key: "dwarf-consonant",
        items: %w[b c d dw f g gl h kw m n ph r st t th thr v w x z]
      },
      {
        key: "dwarf-vowel",
        items: %w[a e i o u]
      },
      {
        key: "dwarf-consonant-suffix",
        items: %w[li four phour lin len mli rin ren son sen don den]
      },
      {
        key: "dwarf-vowel-suffix",
        items: %w[ain oin]
      },
      {
        key: "dwarf-name",
        tags: ["name:first", "tolkien:dwarf", "rpg:dwarf"],
        functions: ["capitalize"],
        items: [
          {
            segments: "[dwarf-consonant][dwarf-vowel][dwarf-consonant-suffix]",
            weight: 20
          },
          {
            segments: "[dwarf-vowel][dwarf-consonant-suffix]"
          },
          {
            segments: "[dwarf-consonant][dwarf-vowel-suffix]"
          }
        ]
      }
    ]
  end

  it "can build a generator from a hash" do
    Eunomia::STORE.add(json)
    request = Eunomia::Request.new("dwarf-name")
    arr = []
    10.times do
      result = request.generate
      expect(result.to_s).to match(/^[A-Z][a-z]+$/)
      arr << result.to_s
    end
    pp arr
  end
end
