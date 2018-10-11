require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_is_letter_number
    assert @game.is_letter_number?('A1')
    assert @game.is_letter_number?('AA99')
    assert @game.is_letter_number?('ZZ90')
    # refute @game.is_letter_and_number?('A1A1')
    # needs to be improved for somthing like this
  end

end
