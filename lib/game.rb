class Game
  def initialize(options)
    @board_x = options[:board_x]
    @board_y = options[:board_y]
    @a_i = options[:a_i]
    @player_board = Board.new(@board_x, @board_y)
    @computer_board = Board.new(@board_x, @board_y)
    @printer_player = Printer.new(@player_board)
    @printer_comp = Printer.new(@computer_board)
  end

  def print_board(person)
    if person == "Player 1"
      puts "Player game board", ""
      @printer_player.print_board
    elsif person == "Computer"
      puts "Computer game board", ""
      @printer_comp.print_board
    else
      puts "Invalid printer"
    end
  end
end
