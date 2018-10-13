class AI
  def get_coord(fleet, ai)
    coord = {}
    if ai == false
      loop do
        coord = find_random_shot(fleet)
        break if unguessed?(fleet, coord)
      end
      return coord
    end

    if ai == true
      # if last shot hit, pick random of 4 adjacent spots
      if fleet.guesses.length >= 1 && fleet.guesses[-1].hit == true
        possible_coords = CoordMath.get_4_coords(fleet.guesses.last.coord, 1)
        possible_coords.sample(4).each do |xy|
          return xy if unguessed?(fleet, xy)
        end
      end

      # # if last 2 shots hit, pick another shot in line
      # if fleet.guesses[-1].hit == true && fleet.guesses[-2].hit == true
      #   possible_coords = CoordMath.get_4_coords(fleet.guesses.last.coord, 1)
      #   possible_coords.sample(4).each do |xy|
      #
      #     return xy if unguessed?(fleet, xy)
      #   end
      # end

      loop do
        coord = find_random_shot(fleet)
        return coord if unguessed?(fleet, coord)
      end
      # fleet.guesses.last.sunk
    end
  end

  def unguessed?(board, coord)
    board.guesses.none?{|g| g.coord == coord}
  end

  def find_random_shot(fleet)
    x_coord, y_coord = rand(fleet.width) + 1, rand(fleet.height) + 1
    {x: x_coord, y: y_coord}
  end

end
