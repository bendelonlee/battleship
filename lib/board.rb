require './lib/ship'
require 'pry'
class Board

  attr_reader :ships, :width, :height

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

  def add_guess(coord)
    @guesses << Guess.new(coord) unless any_guess_at_coord?(coord)
  end

  #query_methods

  def get_possible_end_coords(start_coord, ship_size)
    get_end_coords_in_board(start_coord, ship_size).select do |end_coord|
      space_for_ship?(get_conseq_coords(start_coord, end_coord))
    end
  end

  def all_sunk?
    @ships.all?{|ship| ship.sunk?}
  end

  def any_guess_at_coord?(coord)
    @guesses.any?{|g| g.coord == coord}
  end
  

end
