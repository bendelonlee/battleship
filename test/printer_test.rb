require 'minitest/autorun'
require 'minitest/pride'
require './lib/printer.rb'
require './lib/board.rb'

### Update to run with  board class

class PrinterTest < Minitest::Test
  def setup
    @board = Board.new(2, 2)
    @printer = Printer.new(2, 2)
  end

  def test_it_exists
    assert_instance_of Printer, @printer
  end

  def test_it_creates_blank_board_array
    blank_board = [["=", "=", "=", "=", "="],
                    [".", " ", "1", " ", "2"],
                    ["A", " ", "~", " ", "~"],
                    ["B", " ", "~", " ", "~"],
                    ["=", "=", "=", "=", "="]]
    new_board = @printer.create_board
    assert_equal blank_board, new_board
  end

  def test_it_can_add_ships
    ship_1 = Ship.new([{x: 1, y: 1}, {x: 2, y: 1}])
  end

end
