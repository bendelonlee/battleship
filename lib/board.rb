require './lib/ship'
require 'pry'
require './lib/coord_math'
class Board

  OPPOSITE = {x: :y, y: :x}

  attr_reader :ships, :width, :height, :guesses

  def initialize(width, height)
    @width = width
    @height = height
    @ships  = []
    @guesses = []
  end

  #command_methods
  def add_ship(start_coord, end_coord)
    coords = CoordMath.get_conseq_coords(start_coord, end_coord)
    @ships << Ship.new(coords)
  end

  def add_guess(coord)
    @guesses << Guess.new(coord) unless any_guess_at_coord?(coord)
  end

  #query_methods

  def get_possible_end_coords(start_c, ship_len)
    CoordMath.get_end_coords_in_board(self, start_c, ship_len).select do |end_c|
      space_for_ship?(CoordMath.get_conseq_coords(start_c, end_c))
    end
  end

  def all_sunk?
    @ships.all?{|ship| ship.sunk?}
  end

  def any_guess_at_coord?(coord)
    @guesses.any?{|g| g.coord == coord}
  end

  private

  def space_for_ship?(coords)
    coords.all?{ |c| space_open?(c)}
  end



  def space_open?(coord)
    @ships.none?{|s| s.coords.include?(coord)}
  end

end
