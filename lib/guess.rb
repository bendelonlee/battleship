class Guess
  attr_reader :coord, :hit, :sunk, :ship
  def initialize(board, coord)
    @coord = coord
    @hit = false
    @sunk = false
    board.ships.each do |ship|
      ship.coords.each do |each_coord|
        if each_coord == @coord
          ship.take_hit
          @hit = true
          @sunk = ship.sunk?
          @ship = ship
        end
      end
    end
  end
end
