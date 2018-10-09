require "./test/test_helper"
require "./lib/ship"

class ShipTest < Minitest::Test
  def setup
    @ship = Ship.new([{x:1, y:5},{x:1, y:4}])
    @ship2 = Ship.new([{x:1, y:5},{x:1, y:4},{x:1, y:3}])
  end

  def test_it_holds_coords
    assert_equal ([{x:1, y:5},{x:1, y:4}]), @ship.coords
  end

  def test_it_knows_size
    assert_equal 2, @ship.size
    assert_equal 3, @ship2.size

  end

end
