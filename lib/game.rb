require './lib/board'

class Game 
  attr_reader :user, :computer
  def initialize
    @user = Board.new
    @computer = Board.new
  end

  def run
    main_menu
    computer_place_ships
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit." 
    user_input = gets.chomp
    if user_input != "p" 
      exit
    end
  end

  def computer_place_ships
    computer.
  end
end