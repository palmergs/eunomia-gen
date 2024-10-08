# frozen_string_literal: true

require "spec_helper"
require "json"

RSpec.describe :example_dwarf_names do
  let(:generators) do
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
      },
      {
        key: "dwarf-name-with-parent",
        tags: ["name:first", "tolkien:dwarf", "rpg:dwarf"],
        items: [
          "[dwarf-name] son of [dwarf-name:parent]"
        ]
      }
    ]
  end

  let(:json) do
    str = JSON.pretty_generate(generators)
    JSON.parse(str)
  end

  it "can build a generator from a hash" do
    Eunomia.add(json)
    request = Eunomia::Request.new("dwarf-name", unique: true)
    arr = []
    10.times do
      result = request.generate
      expect(result.to_s).to match(/^[A-Z][a-z]+$/)
      arr << result.to_s
    end
    pp arr
  end

  it "can use a constant to substitute" do
    Eunomia.add(json)
    request = Eunomia::Request.new("dwarf-name-with-parent", unique: true, constants: { "dwarf-name:parent" => "Bob" })
    arr = []
    10.times do
      result = request.generate
      expect(result.to_s).to match(/^[A-Z][a-z]+ son of [A-Z][a-z]+$/)
      arr << result.to_s
    end
    pp arr
  end
end
