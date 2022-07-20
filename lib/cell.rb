class Cell
  attr_reader :coordinate, :ship, :render

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon 
  end

  def fire_upon
    @fired_upon = true
    @ship&.hit 
  end
  
  def render(show_ships = false)
    return "X" if ship&.sunk?
    return "H" if ship && fired_upon?
    return "M" if !ship && fired_upon?
    return "S" if ship && show_ships

    "."
  end
end