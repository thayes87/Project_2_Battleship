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
      Ship.new("cruiser", 3), 
      Ship.new("submarine", 2) 
      ])
    user_instructions
  end
  
  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit." 
    user_input = gets.chomp
    if user_input != "p" 
      exit
    end
  end
  
  def computer_place_ships(ships)
    ships.each do |ship|
      computer_board.place_randomly(ship)
    end
  end

  def user_place_ships(ships)
    puts "Enter the coordinates for the Cruiser (3 units). For example A1, A2, A3"
      user_input = gets.chomp
      if user_board.valid_coordinate?(user_input) == true 
        user_board.place(ship, user_input)
      else puts "Oops that is not a valid coordinate. Please try again."
      end
    end

  def user_instructions
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @user_board.render
    puts "Enter the coordinates for the Cruiser (3 units). For example A1, A2, A3"
    user_input = []
    user_input << gets.chomp
    a = []
    user_input.each do |input|
      a << input.to_s
    end
    puts a
  
    # valid_coordinate?(coordinate)
    if valid_coordinate?(coordinate) == true? && valid_placement(ship, coordinate)
    #   puts user_board.render
    # else puts "Oop those aren't valid coordinates. Try again!"
    # end
   end
end