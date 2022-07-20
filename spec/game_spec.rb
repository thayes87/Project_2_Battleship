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

  it 'user can place ships' do
    game_1 = Game.new
    
    # Simulating user input by mocking gets
    allow(game_1).to receive(:gets).and_return(
      "A1, B1, C1", # first time
      "A2, B2",     # second time
    )

    expect(game_1.user_board.cells.values.count{|c| !c.empty? }).to eq(0)
  
    game_1.user_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
    ])
    
    expect(game_1.user_board.cells.values.count{|c| !c.empty? }).to eq(5)
  end

  it 'can allow player to fire upon cells' do 
    game_1 = Game.new
    allow(game_1).to receive(:gets).and_return(
      "A1, B1, C1", # first time
      "A2, B2",     # second time
      "A1"          # third time 
    )
    
    game_1.computer_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
    ])
    game_1.user_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
    ])
    game_1.take_turn

    expect(game_1.computer_board.cells["A1"].fired_upon?).to eq(true)
    expect(game_1.computer_board.cells["B3"].fired_upon?).to eq(false)
  end

  it 'can allow computer to fire upon cells' do
    game_1 = Game.new
    allow(game_1).to receive(:gets).and_return(
      "A1, B1, C1", # first time
      "A2, B2",     # second time
      "A1"          # third time 
    )
    
    game_1.computer_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
    ])
    game_1.user_place_ships([
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2)
    ])
    game_1.take_turn
    allow(game_1).to receive(:computer_shot).and_return(game_1) 
      
    expect(game_1.user_board.cells.values.count{|c| !c.fired_upon? }).to eq(15) 
  end



end


