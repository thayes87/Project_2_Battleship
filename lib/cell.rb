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

  def render()
    if fired_upon? == false
      "."
    elsif fired_upon? == true && empty? == true
      "M"
    end
  end

end