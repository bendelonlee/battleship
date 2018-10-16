require './test/test_helper'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @ship = Ship.new([{x:1, y:5},{x:1, y:4}])
    @ship2 = Ship.new([{x:1, y:5},{x:1, y:4},{x:1, y:3}])
  end

  def test_it_holds_coords
    assert_equal ([{x:1, y:5},{x:1, y:4}]), @ship.coords
  end

  def test_sinks_when_hit_enough
    2.times{@ship.take_hit}
    assert @ship.sunk?
  end

end
