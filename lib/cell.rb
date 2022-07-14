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
    @ship.hit if @ship
    @fired_upon = true
  end

  def render(show_ships = false)
    return "M" if fired_upon? && empty?
    return "S" if show_ships  
    "."
  end

end