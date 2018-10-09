class Ship
  attr_reader :coords

  def initialize(coords)
    @coords = coords
    @hits = 0
  end

  def sunk?
    @hits >= coords.size
  end

  def take_hit
    @hits += 1
  end

end
