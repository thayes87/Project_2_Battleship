require './lib/board'
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
end