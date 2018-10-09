require "./test/test_helper"
require "./lib/board"
# require 'pry'; binding.pry

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(6, 6)
  end

  def help_add_ship1
    @coords = [{x:1, y:5},{x:1, y:3}]
    @board.add_ship(@coords[0], @coords[1])
  end

  # def help_add_ship [{x:1,y:1}{x:2,y:1}]
  # end

  #coord_math_method_tests
  def test_get_conseq_coords
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = @board.send( :get_conseq_coords, *[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = @board.send( :get_conseq_coords, *[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
  end

  def test_it_adds_ship

    help_add_ship1
    expected = [{x:1, y:3}, {x:1, y:4}, {x:1, y:5}]
    assert_equal expected, @board.ships[0].coords
    
  end

  def test_conseq_true
    skip
    assert @board.coords_conseq?([{x:1, y:5},{x:2, y:5}])
  end

  def test_conseq_false
    skip
    refute @board.coords_conseq?([{x:1, y:5},{x:2, y:4}])
  end



  def test_coord_in_range
    skip
    refute @board.coord_in_range?({x:10,y:1})
    refute @board.coord_in_range?({x:1,y:10})
    assert @board.coord_in_range?({x:4,y:4})

  end


end
