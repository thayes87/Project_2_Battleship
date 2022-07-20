
require 'pry'
require './lib/cell'
class Board
  attr_reader :cells

  def initialize
    @cells = {}

    ("A".."D").each do |letter|
      (1..4).each do |number|
        coordinate = letter + number.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    location = cells[coordinate]
    location&.coordinate == coordinate
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.count != ship.length
    target_cells = coordinates.map { |coordinate| cells[coordinate] }
    return false if target_cells.any?(&:nil?)
    return false unless target_cells.all?(&:empty?)
    
    consecutive_number?(coordinates) ^ consecutive_letter?(coordinates)
  end

  def consecutive_number?(coordinates)
    return false if coordinate_hash(coordinates)[:letters].uniq.count > 1
    coordinate_hash(coordinates)[:numbers].each_cons(2).all? do |num_1, num_2|
      num_1.ord == num_2.ord - 1
    end
  end

  def consecutive_letter?(coordinates)
    return false if coordinate_hash(coordinates)[:numbers].uniq.count > 1
    coordinate_hash(coordinates)[:letters].each_cons(2).all? do |letter_1, letter_2|
      letter_1.ord == letter_2.ord - 1
    end
  end

  def coordinate_hash(coordinates)
    hash = { letters: [], numbers: [] }
    coordinates.each do |coord|
      hash[:letters] << coord[0]
      hash[:numbers] << coord[1..].to_i
    end
    hash
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def place_randomly(ship)
    place(ship, random_placement(ship))
  end

  def random_placement(ship, directions=[:horizontal, :vertical])
    possible_coordinates = []
    until valid_placement?(ship, possible_coordinates) do
      domain = cells.keys
      starting_coordinate = rand(domain.count)
      direction = directions.sample
      if direction == :vertical
        domain = domain.group_by{|k| k[1..] }.values.flatten
      end
      possible_coordinates = domain.slice(starting_coordinate, ship.length)
    end
    possible_coordinates
  end

  def render(show_ships = false)
    output = '  '

    coordinate_hash(@cells.keys)[:numbers].uniq.each do |n|
      output << "#{n} "
    end
    output << "\n"

    coordinate_hash(@cells.keys)[:letters].uniq.each do |l|
      output << "#{l}"
      @cells.each do |coord, cell|
        if cell.coordinate.include?(l)
          output << " #{cell.render(show_ships)}"
        end
      end
      output << " \n"
    end
    output
  end

end
