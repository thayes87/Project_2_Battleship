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
     if location && location.coordinate == coordinate
      true
    else 
      false
    end
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.count != ship.length
    consecutive_number?(coordinates) ^ consecutive_letter?(coordinates)
  end

  def consecutive_number?(coordinates)
    coordinate_hash(coordinates)[:numbers].each_cons(2).all? do |num_1, num_2|
      num_1.ord == num_2.ord - 1
    end
  end

  def consecutive_letter?(coordinates)
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
end
 
