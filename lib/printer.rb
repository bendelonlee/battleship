class Printer
  def initialize(width, height)
    @board_x = width
    @board_y = height
  end

  def print_board(board, show_ships = true)
    create_board
    add_ships(board.ships) if show_ships
    add_guesses(board.guesses)
    print_board_to_screen
  end

  def create_board
    create_blank_board
    initialize_top_rows
    initialize_sides_and_middle
    @print_array
  end

  def create_blank_board
    @print_array = Array.new(@board_y + 3) { Array.new(@board_x * 2 + 1, " ") }
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
          @print_array[y][x] = Out.online? ? "~" : "~".blue
        end
      end
    end
  end

  def add_ships(ships)
    ships.each_with_index do |ship, i|
      ship.coords.length.times do |s|
        @print_array[ship.coords[s][:y] + 1][(ship.coords[s][:x]) * 2] = (i + 1).to_s
      end
    end
  end

  def add_guesses(guesses)
    guesses.each do |guess|
      if guess.hit == true
        if guess.ship.sunk? == true
          mark = "S"
        else
          mark = Out.online? ? "X" : "X".red
        end
      else
        mark = Out.online? ? "*" : "*".yellow
      end
      @print_array[guess.coord[:y] + 1][(guess.coord[:x]) * 2] = mark
    end
  end

  def print_board_to_screen
    @print_array.each do |line|
      Out.put line.join + "\n"
    end
    nil
  end
end
