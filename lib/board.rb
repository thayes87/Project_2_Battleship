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
    ship.length == coordinates.count
    coordinates
  end

end
 
