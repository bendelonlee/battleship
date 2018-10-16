require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/printer.rb'
require './lib/board.rb'

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

end
