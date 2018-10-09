class Ship
  attr_reader :coords, :size

  def initialize(coords)
    @coords = coords
    @hits = 0
    @size = coords.size
  end

  def sunk?
    @hits >= @size
  end

end
