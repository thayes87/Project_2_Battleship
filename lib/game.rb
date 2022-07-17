require './lib/board'

class Game 
  attr_reader :user, :computer
  def initialize
    @user = Board.new
    @computer = Board.new
  end

  def run
    main_menu
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit." 
    if gets.chomp == "q" 
      exit
    end
  end
end