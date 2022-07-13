class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
  end

  def empty?
    if @ship = ship
      false
    else
      true
    end
  end

  def place_ship(ship)
    @ship = ship

  end

end