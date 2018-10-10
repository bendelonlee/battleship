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
  def test_get_conseq_coords
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = @board.send( :get_conseq_coords, *[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = @board.send( :get_conseq_coords, *[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
  end



  def test_get_range_from_coords
    actual = @board.send(:get_range_from_coords, *[[{x:1,y:2},{x:6, y:2}], :x])
    assert_equal (1..6), actual
    assert_instance_of Range, actual
  end


  def test_get_end_coords_in_board
    assert_equal [], @board.send(:get_end_coords_in_board,{x:1, y:1}, 7)
    expected = [{x:6, y:1},{x:1, y:6}]
    assert_equal expected, @board.send(:get_end_coords_in_board,{x:1, y:1}, 6)
    expected = [{x:4, y:3},{x:2, y:3},{x:3, y:4},{x:3, y:2}]
    assert_equal expected, @board.send(:get_end_coords_in_board,{x:3, y:3}, 2)
    expected = [{:x=>3, :y=>4}, {:y=>6, :x=>1}, {:y=>2, :x=>1}]
    assert_equal expected, @board.send(:get_end_coords_in_board,{x:1, y:4}, 3)
  end


  def test_coord_in_board
    refute @board.send(:coord_in_board?,{x:10,y:1})
    refute @board.send(:coord_in_board?,{x:1,y:10})
    assert @board.send(:coord_in_board?,{x:4,y:6})
    refute @board.send(:coord_in_board?,{x:1,y:0})
    refute @board.send(:coord_in_board?,{x:1,y:-1})

  end

  def test_get_4_coords
    actual = @board.send(:get_4_coords,{x:1,y:1}, 4)
    expected = [{:x=>5, :y=>1}, {:x=>-3, :y=>1}, {:y=>5, :x=>1}, {:y=>-3, :x=>1}]
    assert_equal expected, actual
  end

  def test_x_or_y_in_line
    @coords = [{x:1, y:6},{x:1, y:5}]
    assert_equal :x, @board.send(:x_or_y_in_line, @coords)
    @coords = [{x:1, y:5},{x:4, y:5}]
    assert_equal :y, @board.send(:x_or_y_in_line, @coords)
  end

  def test_x_or_y_in_line_returns_false_when_not_in_line
    @coords = [{x:1, y:1},{x:4, y:5}]
    refute @board.send(:x_or_y_in_line, @coords)
  end

  def test_space_for_ship?
    help_add_ship1
    assert @board.send(:coords_in_board?, [{x:1, y:2},{x:2, y:2}])
    assert @board.send(:coords_in_board?, [{x:1, y:3},{x:1, y:2}])
  end



end
