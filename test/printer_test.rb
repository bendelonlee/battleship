require 'minitest/autorun'
require 'minitest/pride'
require './lib/printer.rb'
require './lib/board.rb'

### Update to run with  board class

class PrinterTest < Minitest::Test
  def test_it_exists
    printer = Printer.new(5, 5)
    printer2 = Printer.new(10, 6)
    assert_instance_of Printer, printer
    assert_instance_of Printer, printer2
  end

  def test_it_creates_blank_board_array
    printer = Printer.new(1, 2)
    blank_board = [[" ", " ", " "], [" ", " ", " "],
                  [" ", " ", " "], [" ", " ", " "],
                  [" ", " ", " "]]
    assert_equal blank_board, printer.create_blank_board
  end

  def test_it_responds_to_create_board
    printer = Printer.new(10, 6)
    assert printer.respond_to?(:create_board)
  end

  def test_it_creates_blank_board
    printer = Printer.new(1, 2)
    blank_board = [["=", "=", "="],
                    [".", " ", "1"],
                    ["A", " ", "~"],
                    ["B", " ", "~"],
                    ["=", "=", "="]]
    assert_equal blank_board, printer.create_board
  end

end
