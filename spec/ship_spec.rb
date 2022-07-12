require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_instance_of(Ship)
    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to be(3)
  end
end