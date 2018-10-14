require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    options = { board_width: 4, board_height: 4, ships: [2, 3], a_i: true,
                time_delay: 0, player_1: :computer1, player_2: :computer2,
              output: true}
    @game = Game.new(options)
  end

  def test_is_letter_number
    assert @game.is_letter_number?('A1')
    assert @game.is_letter_number?('A99')
    assert @game.is_letter_number?('Z90')
    # refute @game.is_letter_and_number?('A1A1')
    # needs to be improved for somthing like this
    refute @game.is_letter_number?('1A')
  end

  def test_unguessed
    #should write
  end

  def test_it_can_be_played

  end

end
