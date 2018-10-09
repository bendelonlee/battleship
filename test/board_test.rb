require "./test/test_helper"
require "./lib/board"
# require 'pry'; binding.pry

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(5, 5)
  end

  def help_add_ship
    @coords = [{x:1, y:5},{x:1, y:4}]
    @board.add_ship(@coords)
  end

  # def help_add_ship2 [{x:1,y:1}{x:2,y:1}]
  # end

  def test_it_adds_ship
    help_add_ship
    assert_equal @coords, @board.ships[0].coords
  end

  def test_conseq_true
    @board.coords_conseq?({x:1, y:5},{x:2, y:5})
  end

  def test_conseq_false
    @board.coords_conseq?({x:1, y:5},{x:2, y:4})
  end



  def test_add_ship_checks_space_and_returns_no_space_symbol
    help_add_ship
    assert_equal :no_space, @board.add_ship(@coords)
  end


end
