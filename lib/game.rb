require './lib/board'
require './lib/ship'

class Game
  attr_reader :user_board, :computer_board

  def initialize
    @user_board = Board.new
    @computer_board = Board.new
  end

  def run
    loop { run_round }
  end

  def run_round
    main_menu

    computer_place_ships([
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
    ])

    user_place_ships([
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
    ])

    take_turn until game_over?
  end

  def main_menu
    puts "\nWelcome to BATTLESHIP\n"
    puts "\nEnter p to play. Enter q to quit.\n"
    user_input = gets.chomp
    if user_input != "p"
      exit
    end
  end

  def computer_place_ships(ships)
    ships.each do |ship|
      computer_board.place_randomly(ship)
    end

    puts "\nI have laid out my ships on the grid.\n"
  end

  def user_place_ships(ships)
    puts "\nYou now need to lay out your two ships.\n"
    puts "\nThe Cruiser is three units long and the Submarine is two units long.\n"
    puts @user_board.render(true)

    ships.each do |ship|
      puts "\nEnter the coordinates for the #{ship.name} (#{ship.length} units).\n"

      # 1. Gather user input from the terminal
      user_input = gets.chomp # => "A1, A2, A3"

      # 2. Split the user input into an array of strings, each containing a coordinate
      user_coords = user_input.upcase.split(', ') # => ["A1", "A2", "A3"]

      # 3. Validate that each user coordinate is in fact a valid coordinate
      if !user_coords.all? { |coordinate| user_board.valid_coordinate?(coordinate) }
        puts "\nOops those are not valid coordinates. Please try again.\n"
        redo
      end

      # 4. Validate that the user coordinate array is a valid placement for a crusier
      if !user_board.valid_placement?(ship, user_coords)
        puts "\nOops that is not a valid placement. Please try again.\n"
        redo
      end

      # 5. Place it
      user_board.place(ship, user_coords)
      puts @user_board.render(true)
    end
  end

  def take_turn
    puts "\n=============COMPUTER BOARD=============\n"
    puts computer_board.render
    puts "\n==============PLAYER BOARD==============\n"
    puts user_board.render(true)

    computer_cell = player_shot
    user_cell = computer_shot
    find_results(user_cell, computer_cell)
  end

  def player_shot
    input = ""
    loop do
      input = request_user_coordinate
      if !computer_board.valid_coordinate?(input)
        puts "Oops that is not a valid coordinate. Try again."
      elsif computer_board.cells[input].fired_upon?
        puts "Awww fiddlesticks, you already fired on that one. Try again."
      else
        break
      end
    end

    computer_board.cells[input].fire_upon
    computer_board.cells[input]
  end

  def request_user_coordinate
    puts "\nEnter the coordinate for your shot:\n"
    gets.chomp.upcase
  end

  def computer_shot
    random_cell = user_board.cells.reject{|coord, cell| cell.fired_upon? }.values.sample
    random_cell.fire_upon
    random_cell
  end

  def find_results(user_cell, computer_cell)
    if computer_cell.render == "H"
      puts "Your shot on #{computer_cell.coordinate} was a hit!"
    elsif computer_cell.render == "M"
      puts "Your shot on #{computer_cell.coordinate} was a miss!"
    end
    if user_cell.render == "H"
      puts "My shot on #{user_cell.coordinate} was a hit!"
    elsif user_cell.render == "M"
      puts "My shot on #{user_cell.coordinate} was a miss!"
    end
  end

  def game_over?
    computer_ship_cells = computer_board.cells.values.select { |cell| cell if cell.ship }
    computer_ships_sunk = computer_ship_cells.all? { |cell| cell.ship.sunk? }

    user_ship_cells = user_board.cells.values.select { |cell| cell if cell.ship }
    user_ships_sunk = user_ship_cells.all? { |cell| cell.ship.sunk? }

    if computer_ships_sunk
      puts "You Won!"
      true
    elsif user_ships_sunk
      puts "I Won!"
      true
    else
      false
    end
  end
end
