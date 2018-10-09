class Ship
  attr_reader :coords

  def initialize(coords)
    @coords = coords
    @hits = 0
    @length = coords.size
  end

  def sunk?
    @hits >= @length
  end

end
