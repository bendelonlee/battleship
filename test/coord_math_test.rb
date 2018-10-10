require "./test/test_helper"
require "./lib/coord_math"

class BoardTest < Minitest::Test

  def test_get_conseq_coords
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = CoordMath.get_conseq_coords(*[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
    expected = [{x:1, y:2}, {x:2, y:2}, {x:3, y:2}]
    actual = CoordMath.get_conseq_coords(*[{x:1, y:2}, {x:3, y:2}])
    assert_equal expected, actual
  end

  def test_get_range_from_coords
    actual = CoordMath.get_range_from_coords(*[[{x:1,y:2},{x:6, y:2}], :x])
    assert_equal (1..6), actual
    assert_instance_of Range, actual
  end

  def test_get_end_coords_in_board
    assert_equal [], CoordMath.get_end_coords_in_board({x:1, y:1}, 7)
    expected = [{x:6, y:1},{x:1, y:6}]
    assert_equal expected, CoordMath.get_end_coords_in_board({x:1, y:1}, 6)
    expected = [{x:4, y:3},{x:2, y:3},{x:3, y:4},{x:3, y:2}]
    assert_equal expected, CoordMath.get_end_coords_in_board({x:3, y:3}, 2)
    expected = [{:x=>3, :y=>4}, {:y=>6, :x=>1}, {:y=>2, :x=>1}]
    assert_equal expected, CoordMath.get_end_coords_in_board({x:1, y:4}, 3)
  end

  # def test_coord_in_board
  #   refute CoordMath.coord_in_board({x:10,y:1})
  #   refute CoordMath.coord_in_board({x:1,y:10})
  #   assert CoordMath.coord_in_board({x:4,y:6})
  #   refute CoordMath.coord_in_board({x:1,y:0})
  #   refute CoordMath.coord_in_board({x:1,y:-1})
  # end
  #
  # def test_get_4_coords
  #   actual = CoordMath.get_4_coords({x:1,y:1}, 4)
  #   expected = [{:x=>5, :y=>1}, {:x=>-3, :y=>1}, {:y=>5, :x=>1}, {:y=>-3, :x=>1}]
  #   assert_equal expected, actual
  # end
  #
  # def test_x_or_y_in_line
  #   @coords = [{x:1, y:6},{x:1, y:5}]
  #   assert_equal :x, CoordMath.x_or_y_in_line(@coords)
  #   @coords = [{x:1, y:5},{x:4, y:5}]
  #   assert_equal :y, CoordMath.x_or_y_in_line(@coords)
  # end
  #
  # def test_x_or_y_in_line_returns_false_when_not_in_line
  #   @coords = [{x:1, y:1},{x:4, y:5}]
  #   refute CoordMath.x_or_y_in_line(@coords)
  # end
  #
  # def test_space_for_ship?
  #   help_add_ship1
  #   assert CoordMath.test_space_for_ship?([{x:1, y:2},{x:2, y:2}])
  #   assert CoordMath.test_space_for_ship?([{x:1, y:3},{x:1, y:2}])
  # end

end
