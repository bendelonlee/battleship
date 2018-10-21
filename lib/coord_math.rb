class CoordMath < Hash
  OPPOSITE = {x: :y, y: :x}
  ALPHA_HASH = ("A".."Z").zip(1..26).to_h

  class <<self

    def get_4_coords(start_coord, dist)
      start_coord.map { |k,v|
        [v + dist, v - dist].map do |i|
          opp = OPPOSITE[k]
          {k => i, opp => start_coord[opp]}
        end
      }.flatten
    end

    def get_end_coords_in_board(board, start_coord, ship_size)
      get_4_coords(start_coord, ship_size - 1).select do |c|
        coord_in_board?(board, c)
      end
    end

    def get_conseq_coords(start_coord, end_coord)
      result = []
      coords = [start_coord, end_coord]
      x_or_y = x_or_y_in_line(coords)
      line_val = start_coord[x_or_y]
      get_range_from_coords(coords, OPPOSITE[x_or_y]).each do |i|
        result << {x_or_y => line_val, OPPOSITE[x_or_y] => i}
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
    end

    def in_line?(x_or_y, coords) #not unit tested
      coords.map{|c| c[x_or_y]}.uniq.size == 1
    end

    def coord_in_board?(board, coord)
      coord[:x].between?(1, board.width) && coord[:y].between?(1, board.height)
    end

    def coords_to_s(arr_of_coords)
      arr_of_coords.map{|c|xy_to_alpha_num(c)}.join(", ")
    end

    def alpha_num_to_xy(raw)
      letter = raw[0].upcase
      x_val = raw[1..-1].to_i

      y_val = ALPHA_HASH[letter]
      { x: x_val, y: y_val }
    end

    def xy_to_alpha_num(coord)
      num_to_alpha_hash = ALPHA_HASH.invert
      letter = num_to_alpha_hash[coord[:y]]
      number = coord[:x].to_s
      letter + number
    end

    def is_alpha_number?(str)
      str[/^[a-zA-Z]\d{1,2}$/] ? true : false
    end

  end

end
