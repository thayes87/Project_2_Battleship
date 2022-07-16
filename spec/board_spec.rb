require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:submarine) { Ship.new("Submarine", 2) }

  it 'exists' do
    board.cells

  expect(board).to be_instance_of(Board)
  # require 'pry'; binding.pry
  expect(board.cells.is_a?(Hash)).to be true
  end

  it 'generates all coordinates' do
    expect(board.cells.keys).to eq([
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4",
    ])
    expect(board.cells.values).to all be_instance_of(Cell)
  end

  it 'validates coordinates' do

    expect(board.valid_coordinate?("A1")).to be true
    expect(board.valid_coordinate?("D4")).to be true
    expect(board.valid_coordinate?("A5")).to be false
    expect(board.valid_coordinate?("E1")).to be false
    expect(board.valid_coordinate?("A22")).to be false
    
  end
  
  it 'validates ship placement' do
    # Horizontal happy path
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    # Vertical happy path
    expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to be true
    # High number happy path
    expect(board.valid_placement?(cruiser, ["A11", "A12", "A13"])).to be true
    # Coordinates overlapping
    expect(board.valid_placement?(submarine, ["A1", "A1"])).to be false
    # Ship is too small
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    # Ship is too big
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
    # Non-consecutive
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
    # Backwards
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    # L-shaped consecutive
    expect(board.valid_placement?(cruiser, ["A1", "A2", "B2"])).to be false
    # Diagonal
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
  end
end