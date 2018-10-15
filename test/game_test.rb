require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    options = { board_width: 4, board_height: 4, ships: [2, 3], a_i: true,
                time_delay: 0, player_1: :computer1, player_2: :computer2,
              output: true}
    @game = Game.new(options)
  end



  def test_unguessed
    #should write
  end

  def test_it_can_be_played

  end

end
