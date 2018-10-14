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
      when 2
        if fleet.guesses.last.hit == true && fleet.guesses[-2].hit == true
          return find_random_adjacent_in_line(fleet)
        elsif fleet.guesses.last.hit == true
          return find_random_adjacent(fleet)
        elsif fleet.guesses.last.hit == false && fleet.guesses[-2].hit == true
          return find_other_random_adjacent(fleet, -2)
        else
          return find_random_shot(fleet)
        end
      else
        if fleet.guesses.last.sunk == true
          find_random_shot(fleet)
        elsif fleet.guesses.last.hit == true && fleet.guesses[-2].hit == true
          return find_random_adjacent_in_line(fleet)
        elsif fleet.guesses.last.hit == true && fleet.guesses[-1] == false && fleet.guesses[2] == true
          return find_random_adjacent_in_line_hit_miss_hit(fleet)
        elsif fleet.guesses.last.hit == true
          return find_random_adjacent(fleet)
        elsif fleet.guesses.last.hit == false && fleet.guesses[-2].hit == true && fleet.guesses[-3].hit == true && fleet.guesses.length >= 4 && fleet.guesses[-4].hit == false
          return find_random_adjacent_in_line_opposite_side(fleet, -3, -2)
        elsif fleet.guesses.last.hit == false && fleet.guesses[-2].hit == true && fleet.guesses[-3].hit == true && fleet.guesses.length >= 5 && fleet.guesses[-4].hit == true && fleet.guesses[-5].hit == false
          return find_random_adjacent_in_line_opposite_side(fleet, -4, -3)
        elsif fleet.guesses.last.hit == false && fleet.guesses[-2].hit == true
          return find_other_random_adjacent(fleet, -2)
        elsif fleet.guesses.last.hit == false && fleet.guesses[2].hit == false && fleet.guesses[-3] == true
          return find_other_random_adjacent(fleet, -3)
        else
          return find_random_shot(fleet)
        end
      end
    end
  end

  def find_random_adjacent_in_line_hit_miss_hit(fleet)
    hit_one = fleet.guesses[-3].coord
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

  def find_random_adjacent_in_line_opposite_side(fleet, guess_one, guess_two)
    hit_one = fleet.guesses[guess_one].coord
    hit_two = fleet.guesses[guess_two].coord
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

  def find_other_random_adjacent(fleet, num_to_go_back)
    possible_coords = CoordMath.get_4_coords(fleet.guesses[num_to_go_back].coord, 1)
    possible_coords.sample(4).each do |xy|
      return xy if unguessed?(fleet, xy) && CoordMath.coord_in_board?(fleet, xy)
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
