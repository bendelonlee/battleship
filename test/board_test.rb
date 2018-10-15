require "./test/test_helper"
require "./lib/board"
require 'pry'
require 'set'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(6, 6)
  end

  def help_add_ship1513
    @coords = [{x:1, y:5},{x:1, y:3}]
    @board.add_ship(@coords[0], @coords[1])
  end

  def help_add_ship3531
    coords = [{x:3, y:5},{x:3, y:1}]
    @board.add_ship(coords[0], coords[1])
  end

  def test_get_possible_end_coords_returns_empty_arr
    assert_equal [], @board.get_possible_end_coords({x:1,y:1}, 7)
    assert_equal [], @board.get_possible_end_coords({x:0,y:1}, 2)
  end

  def test_valid_start
    ship_len = 2
    assert  @board.valid_start?({x:2,y:4}, ship_len)
    refute  @board.valid_start?({x:2,y:0}, ship_len)
    refute  @board.valid_start?({x:9,y:2}, ship_len)
    help_add_ship1513
    refute @board.valid_start?({x:1,y:5}, ship_len)
  end

  def test_get_possible_end_coords
    help_add_ship3531
    actual = @board.get_possible_end_coords({x:4, y:4}, 3)
    expected = [{x:6, y:4}, {y:6, x:4}, {y:2, x:4}]
    assert_equal expected, actual
    actual = @board.get_possible_end_coords({x:4, y:4}, 4)
    assert_equal [{y:1, x:4}], actual
  end

  def test_it_adds_ship
    help_add_ship1513
    expected = [{x:1, y:3}, {x:1, y:4}, {x:1, y:5}]
    assert_equal expected, @board.ships[0].coords
  end

  def test_space_for_ship?
    help_add_ship1513
    assert @board.send(:space_for_ship?,[{x:1, y:2},{x:2, y:2}])
    refute @board.send(:space_for_ship?,[{x:1, y:3},{x:1, y:2}])
  end

  def test_it_adds_guesses
    coord = {x:1, y:3}
    @board.add_guess(coord)
    assert_equal coord, @board.guesses.last.coord
    coord = {x:3, y:5}
    @board.add_guess(coord)
    assert_equal coord, @board.guesses.last.coord
    assert_equal 2, @board.guesses.length
  end

  def test_it_knows_when_all_ships_sunk
    coords = [{x:1, y:2},{x:1, y:3}]
    @board.add_ship(coords[0], coords[1])
    coords = [{x:3, y:2},{x:3, y:3}]
    @board.add_ship(coords[0], coords[1])
    assert_equal false, @board.all_sunk?
    @board.add_guess({x:1, y:2})
    @board.add_guess({x:1, y:3})
    @board.add_guess({x:3, y:2})
    @board.add_guess({x:3, y:3})
    assert_equal true, @board.all_sunk?
  end

  def test_it_knows_if_guess_at_coord
    coord = {x:1, y:3}
    assert_equal false, @board.any_guess_at_coord?(coord)
    @board.add_guess(coord)
    assert_equal true, @board.any_guess_at_coord?(coord)
  end


end
