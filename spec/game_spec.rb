require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do
  it 'exists' do 
    game_1 = Game.new
    
    expect(game_1).to be_instance_of(Game)
    expect(game_1.user).to be_instance_of(Board) 
    expect(game_1.computer).to be_instance_of(Board) 
  end
end