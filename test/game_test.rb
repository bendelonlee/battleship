require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    options = { board_width: 4, board_height: 4, ships: [2, 3], a_i: true,
                time_delay: 0, player_1: :player1, player_2: :computer2,
              output: false}
    @game = Game.new(options)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_main_methods
    assert_equal true, @game.respond_to?(:play)
    assert_equal true, @game.respond_to?(:place_ships)
    assert_equal true, @game.respond_to?(:print_board)
    assert_equal true, @game.respond_to?(:play_round)
    assert_equal true, @game.respond_to?(:winner_message)
    assert_equal true, @game.respond_to?(:playing_loop)
  end

  def test_it_knows_it_spot_is_unguessed
    @board = Board.new(5, 5)
    assert_equal true, @game.unguessed?(@board, {x:2, y:4})
    @board.add_guess({x:2, y:4})
    assert_equal false, @game.unguessed?(@board, {x:2, y:4})
  end
end
