class AI
  def get_coord(fleet, ai)
    if ai == false
      return find_random_shot(fleet)
    end

    if ai == true
      case fleet.guesses.length
      when 0
        find_random_shot(fleet)
      when 1
        if fleet.guesses.last.hit == true
          return find_random_adjacent(fleet)
        else
          return find_random_shot(fleet)
        end
      else
        if fleet.guesses.last.hit == true && fleet.guesses[-2].hit == true
          return find_random_adjacent_in_line(fleet)
        elsif fleet.guesses.last.hit == true
          return find_random_adjacent(fleet)
        else
          return find_random_shot(fleet)
        end
      end
    end
  end

  def find_random_adjacent_in_line(fleet)
    hit_one = fleet.guesses[-2].coord
    hit_two = fleet.guesses[-1].coord
    hits = [hit_one, hit_two]
    dir_in_line = CoordMath.x_or_y_in_line(hits)
    unless dir_in_line == nil
      possible_coords = CoordMath.get_4_coords(fleet.guesses.last.coord, 1)
      possible_coords.sample(4).each do |xy|
        if unguessed?(fleet, xy) && CoordMath.coord_in_board?(fleet, xy)
          if hit_one[dir_in_line] == xy[dir_in_line]
            return xy
          end
        end
      end
    end
    find_random_shot(fleet)
  end

  def find_random_adjacent(fleet)
    possible_coords = CoordMath.get_4_coords(fleet.guesses.last.coord, 1)
    possible_coords.sample(4).each do |xy|
      return xy if unguessed?(fleet, xy) && CoordMath.coord_in_board?(fleet, xy)
    end
    find_random_shot(fleet)
  end

  def unguessed?(board, coord)
    board.guesses.none?{|g| g.coord == coord}
  end

  def find_random_shot(fleet)
    loop do
      x_coord, y_coord = rand(fleet.width) + 1, rand(fleet.height) + 1
      coord = {x: x_coord, y: y_coord}
      return coord if unguessed?(fleet, coord)
    end
  end

end
