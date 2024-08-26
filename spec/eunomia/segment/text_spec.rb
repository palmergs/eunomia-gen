require 'spec_helper'

RSpec.describe Eunomia::Segment::Text do
  it 'can be parsed' do
    t = Eunomia::Segment::Text.parse("test")
    expect(t.text).to eq("test")
  end

  it 'ignores numbers' do
    t = Eunomia::Segment::Text.parse('1234')
    expect(t).to be_nil
  end

  it 'ignores references' do
    t = Eunomia::Segment::Text.parse(':3d8+4')
    expect(t).to be_nil
  end
end
