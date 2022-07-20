require './lib/board'
require './lib/ship'
require 'pry'

class Game 
  attr_reader :user_board, :computer_board 

  def initialize
    @user_board = Board.new
    @computer_board = Board.new
  end
  
  def run
    main_menu

    computer_place_ships([
      Ship.new("Cruiser", 3), 
      Ship.new("Submarine", 2) 
    ])

    user_place_ships([
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2) 
    ])

    take_turn 
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
    puts "\nNOW IT'S TIME TO PLAY!!!\n"
    puts "\n=============COMPUTER BOARD=============\n"
    puts computer_board.render
    puts "\n==============PLAYER BOARD==============\n"
    puts user_board.render(true)
        
    input = request_user_coordinate
    
    until computer_board.valid_coordinate?(input)
      puts "Oops that is not a valid coordinate. Try again."
      input = request_user_coordinate
    end

    computer_board.cells[input].fire_upon
    computer_cell = computer_board.cells[input]
    user_cell = computer_shot
    find_results(user_cell, computer_cell)
    game_over?
  end

  def request_user_coordinate
    puts "\nEnter the coordinate for your shot:\n"
    gets.chomp.upcase
  end

  def computer_shot
     random_coord = user_board.cells.keys.sample
    unless user_board.cells[random_coord].fired_upon? 
      user_board.cells[random_coord].fire_upon
      user_board.cells[random_coord]
    end
  end

  def find_results(user_cell, computer_cell)
    require 'pry'; binding.pry
    if computer_cell.render == "H"
      puts "Your shot on #{computer_cell.coordinate} was a hit!"
    elsif 
       computer_cell.render == "M"
       puts "Your shot on #{computer_cell.coordinate} was a hit!"
    end

  end
  # puts "\n=============COMPUTER BOARD=============\n"
  # puts computer_board.render 
end