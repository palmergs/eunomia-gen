# frozen_string_literal: true

require "spec_helper"

RSpec.describe :example_dwarf_names do
  let(:json) do
    [
      {
        key: "dwarf-prefix",
        items: %w[ba bi bo be bu cha che cho da do di de du e eck fa fo fi fe ga gam ge gem go gom gi gim ha ho hom ham
                  hem him hi he ka ko ke ki ma mo na no pa po pi pe quo qua quam ra ro ri re ta tha to tho thro thra te
                  ohe tho ro wa wo xa]
      },
      {
        key: "dwarf-suffix",
        items: %w[lin len lon lun lphour lfor mli li rin ran ro ron rum van von ven vo pan pon po pen]
      },
      {
        key: "dwarf-unique-name",
        items: %w[dain thorin thror thrain drasa]
      },
      {
        key: "dwarf-name",
        tags: ["name:first", "tolkien:dwarf", "rpg:dwarf"],
        functions: ["capitalize"],
        items: [
          {
            segments: "[dwarf-prefix][dwarf-suffix]",
            weight: 500
          },
          {
            segments: "[dwarf-unique-name]",
            weight: 1
          }
        ]
      }
    ]
  end

  it "can build a generator from a hash" do
    Eunomia::STORE.add(json)
    request = Eunomia::Request.new("dwarf-name")
    result = request.generate
    pp result
    p "Result: #{result}"
  end
end
