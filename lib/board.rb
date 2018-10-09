require './lib/ship'
class Board
  attr_reader :ships, :guesses

  def initialize(width, height)
    @width = width
    @height = height
    @ships  = []
    @guesses = []
  end

  #command_methods
  def add_ship(coords)
    info = validate_coords(coords)
    if info == :valid
      @ships << Ship.new(coords)
    end
    return info
  end



  #query_methods

  def validate_coords(coords)
    return :intersecting unless space_for_ship?(coords)
    return :nonconseq unless coords_conseq?(coords)
    return :out_of_range unless in_range?(coords)
    return :valid
  end

  def coords_conseq?(coords)
    xvals = coords.map{|c| c[:x]}
    yvals = coords.map{|c| c[:y]}
    xvals.uniq.size == 1 || yvals.uniq.size == 1
  end

  def coords_in_range?(coords)
    coords.each {|c| coord_in_range?(c)}
  end
  def coord_in_range?(coord)
    coord[:x] < (@width - 1) && coord[:y] < (@height - 1)
  end

  def space_for_ship?(coords)
    coords.all?{ |c| space_open?(c)}
  end
  def space_open?(coord)
    @ships.none?{|s| s.coords.include?(coord)}
  end

end
