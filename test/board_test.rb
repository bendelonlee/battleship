require "./test/test_helper"
require "./lib/board"
# require 'pry'; binding.pry

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(6, 6)
  end

  def help_add_ship
    @coords = [{x:1, y:5},{x:1, y:4}]
    @board.add_ship(@coords)
  end

  # def help_add_ship2 [{x:1,y:1}{x:2,y:1}]
  # end

  def test_it_adds_ship
    assert_equal :valid, help_add_ship
    assert_equal @coords, @board.ships[0].coords

  end

  def test_conseq_true
    assert @board.coords_conseq?([{x:1, y:5},{x:2, y:5}])
  end

  def test_conseq_false
    refute @board.coords_conseq?([{x:1, y:5},{x:2, y:4}])
  end



  def test_add_ship_can_return_intersecting
    help_add_ship
    assert_equal :intersecting, @board.add_ship(@coords)
    assert_equal :intersecting, @board.add_ship([{x:1, y:5},{x:2,y:5}])
    assert_equal 1, @board.ships.size
  end

  def test_add_ship_can_return_out_of_range
    assert_equal :out_of_range, @board.add_ship([{x:1, y:10},{x:2,y:10}])

  end

  def test_coord_in_range
    refute @board.coord_in_range?({x:10,y:1})
    refute @board.coord_in_range?({x:1,y:10})
    assert @board.coord_in_range?({x:4,y:4})

  end


end
