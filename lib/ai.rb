class AI
  def get_coord(fleet, ai)
    @fleet = fleet

    if ai == false
      return find_random_shot(fleet)
    end

    if ai == true
      case fleet.guesses.length
      when 0 # at the start of the game pick a random spot
        find_random_shot(fleet)
      when 1 # if first shot hit a ship then find an adjacent shot, otherwise random
        previous_guesses[1] ? (return find_random_adjacent(fleet)) : (return find_random_shot(fleet))
      when 2 # when 2 shots have been taken
        # if the previous 2 shots hit, then find another in that line of hits
        if previous_guesses[1] && previous_guesses[2]
          return find_random_adjacent_in_line(fleet)
        elsif previous_guesses[1] # otherwise if only previous shot hit, hit adjacent
          return find_random_adjacent(fleet)
        elsif !previous_guesses[1] && previous_guesses[2] # if first hit was good but
          # not the second shot then try another shot next ot the first shot
          return find_other_random_adjacent(fleet, -2)
        else
          return find_random_shot(fleet) # if all fails return a random guess
        end
      else # when the game has at least 3 shots on the board
        if fleet.guesses.last.sunk # if you sunk a ship try a random guess
          find_random_shot(fleet)
        elsif previous_guesses[1] && previous_guesses[2] # if both previous shots
          # hit ships then continue in a line
          return find_random_adjacent_in_line(fleet)
        elsif previous_guesses[1] && !previous_guesses[2] && previous_guesses[3]
          # if you hit a ship, but then missed, try another shot near the first shot
          return find_random_adjacent_in_line_hit_miss_hit(fleet)
        elsif previous_guesses[1]
          # try the last adjacent shot next to a hit if you get here
          return find_random_adjacent(fleet)
        elsif !previous_guesses[1] && previous_guesses[2] && previous_guesses[3] &&
              fleet.guesses.length >= 4 && !previous_guesses[4]
              # if you were shooting a ship but then hit water then wrap around to
              # the other side of the string of hits
          return find_random_adjacent_in_line_opposite_side(fleet, -3, -2)
        elsif !previous_guesses[1] && previous_guesses[2] && previous_guesses[3] &&
              fleet.guesses.length >= 5 && previous_guesses[4] && !previous_guesses[5]
              # same as before but with longer ships
          return find_random_adjacent_in_line_opposite_side(fleet, -4, -3)
        elsif !previous_guesses[1] && previous_guesses[2]
          # try adjacent space next to hit if you hit then missed
          return find_other_random_adjacent(fleet, -2)
        elsif !previous_guesses[1] && !previous_guesses[2] && previous_guesses[3]
          # try another adjacent next to hit if you hit then missed then missed
          return find_other_random_adjacent(fleet, -3)
        else
          # if nothing else do a random shot
          return find_random_shot(fleet)
        end
      end
    end
  end

  def previous_guesses
    guess_array = []
    (1...@fleet.guesses.length).each do |i|
      guess_array << @fleet.guesses[-i].hit
    end
    guess_array.unshift(0)
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
