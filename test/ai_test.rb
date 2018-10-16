require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ai'
require './lib/board'

class AITest < Minitest::Test
  def setup
    @board = Board.new(6, 6)
    coords = [{x:2, y:2},{x:2, y:3}, {x:2, y:4}, {x:2, y:5}]
    @board.add_ship(coords[0], coords[3])
    @ai = AI.new
  end

  def board
    @board = Board.new(6, 6)
  end

  def test_it_exists
    assert_instance_of AI, @ai
  end

  def test_it_picks_random_shot_first
    coord_ai = @ai.get_coord(@board, true)
    coord_no_ai = @ai.get_coord(@board, false)
    assert_equal true, coord_ai[:x].between?(1, 6)
    assert_equal true, coord_ai[:y].between?(1, 6)
    assert_equal true, coord_no_ai[:x].between?(1, 6)
    assert_equal true, coord_no_ai[:y].between?(1, 6)
  end

  def test_it_hits_next_to_good_shot
    @board.add_guess({x:2, y:3})
    coord = @ai.get_coord(@board, true)
    c1 = {x:1, y:3}
    c2 = {x:3, y:3}
    c3 = {x:2, y:2}
    c4 = {x:2, y:4}
    result = coord == c1 || coord == c2 || coord == c3 || coord == c4
    assert_equal true, result
  end

  def test_it_hits_next_to_good_shot_after_first_shot
    @board.add_guess({x:6, y:6})
    @board.add_guess({x:2, y:3})
    coord = @ai.get_coord(@board, true)
    c1 = {x:1, y:3}
    c2 = {x:3, y:3}
    c3 = {x:2, y:2}
    c4 = {x:2, y:4}
    result = coord == c1 || coord == c2 || coord == c3 || coord == c4
    assert_equal true, result
  end

  def test_it_hits_next_to_good_shot_after_second_shot
    @board.add_guess({x:6, y:6})
    @board.add_guess({x:5, y:6})
    @board.add_guess({x:2, y:3})
    coord = @ai.get_coord(@board, true)
    c1 = {x:1, y:3}
    c2 = {x:3, y:3}
    c3 = {x:2, y:2}
    c4 = {x:2, y:4}
    result = coord == c1 || coord == c2 || coord == c3 || coord == c4
    assert_equal true, result
  end

  def test_it_continues_on_shot_path
    @board.add_guess({x:2, y:3})
    @board.add_guess({x:2, y:4})
    expected = {x:2, y:5}
    assert_equal expected, @ai.get_coord(@board, true)
  end

  def test_it_wraps_back_after_misses_in_line
    @board.add_guess({x:2, y:4})
    @board.add_guess({x:2, y:5})
    @board.add_guess({x:2, y:6})
    expected = {x:2, y:3}
    assert_equal expected, @ai.get_coord(@board, true)
  end

  def test_it_has_array_of_guess_booleans
    @board.add_guess({x:2, y:4})
    @board.add_guess({x:2, y:5})
    @board.add_guess({x:2, y:6})
    @ai.get_coord(@board, true) # keep to initialize @fleet
    expected = [true, true, false]
    assert_equal expected, @ai.previous_guesses_array
  end

  def test_it_knows_unguessed_spaces
    @board.add_guess({x:2, y:4})
    @board.add_guess({x:2, y:5})
    assert_equal true, @ai.unguessed?(@board, {x:2, y:6})
    @board.add_guess({x:2, y:6})
    assert_equal false, @ai.unguessed?(@board, {x:2, y:6})
    assert_equal true, @ai.unguessed?(@board, {x:1, y:3})
    assert_equal false, @ai.unguessed?(@board, {x:2, y:4})
  end
end
