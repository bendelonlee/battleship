class CoordMath < Hash
  OPPOSITE = {x: :y, y: :x}

  class <<self
    
    def get_neighbors(coord)
      get_4_coords(coord, 1)
    end

    def get_4_coords(start_coord, dist)
      start_coord.map { |k,v|
        [v + dist, v - dist].map do |i|
          opp = OPPOSITE[k]
          {k => i, opp => start_coord[opp]}
        end
      }.flatten
    end

    def get_conseq_coords(start_coord, end_coord)
      result = []
      coords = [start_coord, end_coord]
      x_or_y = x_or_y_in_line(coords)
      line_val = start_coord[x_or_y]
      get_range_from_coords(coords, OPPOSITE[x_or_y]).each do |i|
        result << {x_or_y => line_val, OPPOSITE[x_or_y] => i}
        # require 'pry'; binding.pry
      end
      result
    end

    def get_range_from_coords(coords, x_or_y)
      nums = coords[0][x_or_y], coords[1][x_or_y]
      (nums.min..nums.max)
    end

    def x_or_y_in_line(coords)
      return :x if in_line?(:x, coords)
      return :y if in_line?(:y, coords)
      false
    end

    def in_line?(x_or_y, coords)
      coords.map{|c| c[x_or_y]}.uniq.size == 1
    end

    def coord_in_board?(coord, board)
      coord[:x].between?(1, board.width) && coord[:y].between?(1, board.height)
    end



    def space_for_ship?(coords)
      coords.all?{ |c| space_open?(c)}
    end
    def space_open?(coord, ships)
      ships.none?{|s| s.coords.include?(coord)}
    end

  end

end
