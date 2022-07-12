require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_instance_of(Ship)
    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to be(3)
  end

  it 'has health' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it 'is sunk?' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be(false)
  end

  it 'can take a hit' do
    cruiser = Ship.new("Cruiser", 3)

    cruiser.hit

    expect(cruiser.health).to eq(2) 
  end

end