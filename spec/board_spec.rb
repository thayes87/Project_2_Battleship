require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  let(:board) { Board.new }

  it 'exists' do
    board.cells

  expect(board).to be_instance_of(Board)
  # require 'pry'; binding.pry
  expect(board.cells.is_a?(Hash)).to be true
  end

  

end