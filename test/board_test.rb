require "./test/test_helper"
require "./lib/board"
require 'pry'
require 'set'
# require 'pry'; binding.pry

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(6, 6)
  end

  def help_add_ship1
    @coords = [{x:1, y:5},{x:1, y:3}]
    @board.add_ship(@coords[0], @coords[1])
  end

  def help_add_ship2
    coords = [{x:3, y:5},{x:3, y:1}]
    @board.add_ship(coords[0], coords[1])
  end

  # def help_add_ship [{x:1,y:1}{x:2,y:1}]
  # end


  #public tests
  def test_get_possible_end_coords_returns_empty_arr
    assert_equal [], @board.get_possible_end_coords({x:1,y:1}, 7)
  end

  def test_get_possible_end_coords
    help_add_ship2
    actual = @board.get_possible_end_coords({x:4, y:4}, 3)
    expected = [{x:6, y:4}, {y:6, x:4}, {y:2, x:4}]
    assert_equal expected, actual
    actual = @board.get_possible_end_coords({x:4, y:4}, 4)
    assert_equal [{y:1, x:4}], actual
  end

  def test_it_adds_ship
    help_add_ship1
    expected = [{x:1, y:3}, {x:1, y:4}, {x:1, y:5}]
    assert_equal expected, @board.ships[0].coords
  end

  #coord_math_method_tests
  


end
