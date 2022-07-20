require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  before { allow(game).to receive(:puts) }

  it 'exists' do
    expect(game).to be_instance_of(Game)
    expect(game.user_board).to be_instance_of(Board)
    expect(game.computer_board).to be_instance_of(Board)
  end

  it 'computer can place ships' do
    expect(game.computer_board.cells.values.count{|c| !c.empty? }).to eq(0)

    game.computer_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])

    expect(game.computer_board.cells.values.count{|c| !c.empty? }).to eq(5)
  end

  it 'user can place ships' do
    # Simulating user input by mocking gets
    allow(game).to receive(:gets).and_return(
      "A1, B1, C1", # first time
      "A2, B2",     # second time
    )

    expect(game.user_board.cells.values.count{|c| !c.empty? }).to eq(0)

    game.user_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])

    expect(game.user_board.cells.values.count{|c| !c.empty? }).to eq(5)
  end

  it 'can allow player to fire upon cells' do
    allow(game).to receive(:gets).and_return(
      "A1, B1, C1", # place the cruiser
      "A2, B2",     # place the submarine
      "A1",         # fire on A1
    )

    # end the game after one turn to avoid infinite loops
    allow(game).to receive(:game_over?).and_return(true)

    game.computer_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])
    game.user_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])
    game.take_turn

    expect(game.computer_board.cells["A1"].fired_upon?).to eq(true)
    expect(game.computer_board.cells["B3"].fired_upon?).to eq(false)
  end

  it 'can allow computer to fire upon cells' do
    allow(game).to receive(:gets).and_return(
      "A1, B1, C1", # place the cruiser
      "A2, B2",     # place the submarine
    )
    # simulate the user shooting to avoid actually prompting for input
    allow(game).to receive(:player_shot).and_return(game.computer_board.cells.values.first)
    # end the game after one turn to avoid infinite loops
    allow(game).to receive(:game_over?).and_return(true)

    game.computer_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])
    game.user_place_ships([
      Ship.new("cruiser", 3),
      Ship.new("submarine", 2)
    ])
    game.take_turn

    expect(game.user_board.cells.values.count{|c| !c.fired_upon? }).to eq(15)
  end

  it 'plays a game until completion' do
    allow(game).to receive(:gets).and_return(
      "p", # press "p" to play

      "A1, B1, C1", # place the cruiser
      "A2, B2",     # place the submarine

      # fire on every cell sequentially
      *game.computer_board.cells.keys,
    )
    allow(game).to receive(:computer_shot).and_return(game.user_board.cells.values.first)

    game.run

    expect(game).to have_received(:puts).with("You Won!")
  end
end


