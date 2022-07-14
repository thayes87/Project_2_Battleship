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
    expect(cell.fired_upon?).to be(false)  
  end 
  
  it 'can take a hit' do
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    
    cell.place_ship(cruiser)

    cell.fire_upon

    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be(true)
  end

  it 'can render empty cell' do
    cell_1 = Cell.new("B4")
    cell_1.render

    expect(cell_1.render).to eq(".")

    cell_1.fire_upon
    cell_1.render
    expect(cell_1.render).to eq("M")
  end
  
  it 'can render cell with ship' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.render

    expect(cell_2.render).to eq(".")
  end

  it 'can render an optional argument' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.render(true)

    expect(cell_2.render(true)).to eq("S")
  end
end