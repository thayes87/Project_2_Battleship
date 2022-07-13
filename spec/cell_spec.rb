require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")

    expect(cell).to be_instance_of(Cell)
    expect(cell.coordinate).to eq("B4")
    expect(cell.ship).to be(nil)
    expect(cell.empty?).to be(true)
  end

  it 'places the ship' do
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    
    cell.place_ship(cruiser)

    expect(cell.ship).to be(cruiser)
    expect(cell.empty?).to be(false)
  end 
end