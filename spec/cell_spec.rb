require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  let(:cell) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:cell_2) { Cell.new("C3") }
  
  it 'exists' do
    
    expect(cell).to be_instance_of(Cell)
    expect(cell.coordinate).to eq("B4")
    expect(cell.ship).to be(nil)
    expect(cell.empty?).to be(true)
  end

  it 'places the ship' do
    
    cell.place_ship(cruiser)

    expect(cell.ship).to be(cruiser)
    expect(cell.empty?).to be(false)
    expect(cell.fired_upon?).to be(false)  
  end 
  
  it 'can take a hit' do

    cell.place_ship(cruiser)

    cell.fire_upon

    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be(true)
  end
  
  it 'can render empty cell' do
    cell.render

    expect(cell.render).to eq(".")

    cell.fire_upon
    cell.render

    expect(cell.render).to eq("M")
  end
  
  it 'can render cell with ship' do
     
    cell_2.place_ship(cruiser)
    cell_2.render

    expect(cell_2.render).to eq(".")
  end

  it 'can render an optional argument' do
     
    cell_2.place_ship(cruiser)
    cell_2.render(true)

    expect(cell_2.render(true)).to eq("S")
    
    cell_2.fire_upon
    cell_2.render
    
    expect(cell_2.render).to eq("H")
    expect(cruiser.sunk?).to be(false)

    cruiser.hit
    cruiser.hit

    expect(cruiser.sunk?).to be(true)

    cell_2.render

    expect(cell_2.render).to eq("X")
  end
end