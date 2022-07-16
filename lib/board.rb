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
    consecutive_number?(coordinates)
  end

  def consecutive_number?(coordinates)
    pp coordinate_hash(coordinates)
    coordinate_hash(coordinates)[:number].each_cons(2).all? do |num_1, num_2|
      num_1.to_i == num_2.to_i - 1
    end
  end

  def coordinate_hash(coordinates)
    hash = Hash.new { |k,v| k[v] = [] }
    coordinates.each do |coord|
      hash[:letter] << coord[0]
      hash[:number] << coord[1]
    end
    hash
  end

  def consecutive_letter?
    coordinate_hash(coordinates)[:letter].each_cons(2).all? do |letter_1, letter_2|
      letter_1.ord == letter_2.ord - 1
    end
  end
end
 
