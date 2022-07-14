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
    return render_reveal if show_ships
    return "." unless fired_upon?
    return "M" if empty?  
    ship.sunk? ? "X" : "H" 
   end
  private 
  def render_reveal
    empty? ? "." : "S"
  end
end