# frozen_string_literal: true

RSpec.describe Eunomia::Function::Titleize do
  it "titleizes strings" do
    tests = {
      "a wrinkle in time" => "A Wrinkle in Time",
      "the grade was an a" => "The Grade Was an A"
    }

    f = Eunomia::Function::Titleize.new
    tests.each_pair do |s, x|
      expect(f.apply(s)).to eq(x)
    end
  end
end
