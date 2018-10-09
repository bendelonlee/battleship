require './lib/ship'
class Board

  OPPOSITE = {x: :y, y: :x}

  attr_reader :ships, :guesses

  def initialize(width, height)
    @width = width
    @height = height
    @ships  = []
    @guesses = []
  end

  #command_methods
  def add_ship(start_coord, end_coord)
      coords = get_conseq_coords(start_coord, end_coord)
      @ships << Ship.new(coords)
  end

  #query_methods

  def space_for_ship_at_start_coord?(start_coord, ship_size)
    get_possible_end_coords(start_coord, ship_size).any?
  end

  def get_possible_end_coords(start_coord, ship_size)
    get_end_coords_in_board(start_coord, ship_size).select do |end_coord|
      space_for_ship?(get_conseq_coords(start_coord, end_coord))
    end
  end

  private

  def get_end_coords_in_board(start_coord, ship_size)
    result = []
    start_coord.each do |k,v|
      [v + 4, v - 4].each do |i|
         result << {k => i} if i <= @width
      end
    end
    result
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

  def coords_in_board?(coords)
    coords.each {|c| return false unless coord_in_board?(c) }
    true
  end
  def coord_in_board?(coord)
    coord[:x] < (@width) && coord[:y] < (@height)
  end

  def space_for_ship?(coords)
    coords.all?{ |c| space_open?(c)}
  end
  def space_open?(coord)
    @ships.none?{|s| s.coords.include?(coord)}
  end

end
