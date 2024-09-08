# frozen_string_literal: true

RSpec.describe Eunomia::Function::Capitalize do
  it "capitalizes an array" do
    arr = %w[this is a test]
    expect(Eunomia::Function::Capitalize.new.apply(arr)).to eq(%w[This Is A Test])
  end
end
