class Printer
  def initialize(board_x, board_y)
    @board_x = board_x
    @board_y = board_y
    create_board
  end

  def create_board
    create_blank_board
    initialize_top_rows
    initialize_sides_and_mddle
    @print_array
  end

  def create_blank_board
    @print_array = Array.new(@board_y + 3, " ") { Array.new(@board_x * 2 + 1, " ") }
  end

  def initialize_top_rows
    @print_array[0].map! { "=" }
    @print_array[1].each_with_index do |val, x|
      if x == 0
        @print_array[1][x] = "."
      else
        if x % 2 == 0
          @print_array[1][x] = (x / 2).to_s
        end
      end
    end
  end

  def initialize_sides_and_middle
    alphabet = ('A'..'Z').to_a
    @print_array.each_with_index  do |val_y, y|
      @print_array[y].each_with_index do |val_x, x|
        if x == 0 && y <= 27 && y > 1 && y < @board_y + 2
          @print_array[y][x] = alphabet[y - 2]
        elsif y == @print_array.length - 1
          @print_array[y][x] = "="
        elsif y > 1 && x % 2 == 0
          @print_array[y][x] = "~"
        end
      end
    end
  end

  def update(guesses, ships={})
    guesses.each do |guess|
      
    end
  end

  def print_board
    @print_array.each do |line|
      print line.join + "\n"
    end
    nil
  end
end
