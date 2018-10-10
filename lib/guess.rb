class Guess
  attr_reader :coord, :hit
  def initialize(board, coord)
    @coord = coord
    @hit = false
    board.ships.each do |ship|
      ship.coords.each do |each_coord|
        if each_coord == @coord
          @hit = true
        end
      end
    end
  end
end
