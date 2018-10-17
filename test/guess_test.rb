require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/guess'
require './lib/board'
require 'pry'

class GuessTest < Minitest::Test
  def test_it_exists
    board = Board.new(4, 4)
    coord = {x: 3, y: 2}
    guess = Guess.new(board, coord)
    assert_instance_of Guess, guess
  end

  def test_it_can_read_coord_of_guess
    board = Board.new(4, 4)
    coord = {x: 3, y: 2}
    guess = Guess.new(board, coord)
    assert_equal coord, guess.coord
  end

  def test_it_can_tell_if_guess_hit
    board = Board.new(4, 4)
    board.add_ship({x: 1, y: 2}, {x: 2, y: 2})
    coord = {x: 2, y: 2}
    guess = Guess.new(board, coord)
    assert_equal true, guess.hit
    new_coord = {x: 4, y: 4}
    new_guess = Guess.new(board, new_coord)
    assert_equal false, new_guess.hit
  end

  def test_it_can_tell_if_guess_sunk_ship
    board = Board.new(4, 4)
    board.add_ship({x: 1, y: 2}, {x: 2, y: 2})
    coord = {x: 2, y: 2}
    guess = Guess.new(board, coord)
    assert_equal false, guess.sunk
    new_coord = {x: 1, y: 2}
    new_guess = Guess.new(board, new_coord)
    assert_equal true, new_guess.sunk
  end

  def test_it_can_recall_guess_data
    board = Board.new(4, 4)
    board.add_ship({x: 1, y: 2}, {x: 2, y: 2})
    coord = {x: 2, y: 2}
    guess = Guess.new(board, coord)
    assert_equal true, guess.hit
    new_coord = {x: 2, y: 3}
    new_guess = Guess.new(board, new_coord)
    assert_equal false, new_guess.hit    
  end
end
