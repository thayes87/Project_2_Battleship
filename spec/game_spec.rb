require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do
  it 'exists' do 
    game_1 = Game.new
    
    expect(game_1).to be_instance_of(Game)
    expect(game_1.user_board).to be_instance_of(Board) 
    expect(game_1.computer_board).to be_instance_of(Board) 
  end

  it 'computer can place ships' do
    game_1 = Game.new

    expect(game_1.computer_board.cells.values.count{|c| !c.empty? }).to eq(0)
  
    game_1.computer_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
      ])
    
    expect(game_1.computer_board.cells.values.count{|c| !c.empty? }).to eq(5)
  end
end
