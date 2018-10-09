require './lib/board.rb'
require './lib/printer.rb'
require 'pry'

class Game
  def initialize(options)
    board_width = options[:board_width]
    board_height = options[:board_height]
    ship_lengths = options[:ships]
    # a_i = options[:a_i]

    @player_board = Board.new(board_width, board_height)
    @computer_board = Board.new(board_width, board_height)

    @printer = Printer.new

    place_computer_ships(ship_lengths)
    place_player_ships(ship_lengths)

    loop do
      player_round(@player_board, "Player")
      if game_over? @player_board
        puts "You have defeated the enemy!!!"
        break
      end
      computer_round(@computer_board, "Computer")
      if game_over? @computer_board
        puts "The enemy has defeated your fleet!"
        break
      end
    end
    puts "Complete"
  end

  def game_over? board
    sunk_ships = 0
    board.ships.each do |ship|
      sunk_ships += 1 if ship.sunk?
    end
    if sunk_ships == board_ships.length
      return true
    else
      return false
    end
  end

  def place_player_ships(ship_lengths)
    # quick instuction
    ship_lengths.each do |len|
      @printer.print_board(@player_board)
      puts "Time to place a #{len} unit long ship"
      puts "Enter start coordinate (Ex. A3)"
      print "> "
      start_raw = $stdin.gets.chomp
      puts "Enter end coordinate (Ex. A5)"
      print "> "
      end_raw = $stdin.gets.chomp
      start_coord = convert(start_raw)
      end_coord = convert(end_raw)
      @player_board.add_ship(start_coord, end_coord)
    end
    puts "Ship placement complete:"
    @printer.print_board(@player_board)
    sleep 3
  end

  def convert(raw)
    letter = raw[0].upcase
    x_val = raw[1..-1].to_i - 1
    alpha_hash = ("A".."Z").zip(1..26).to_h
    y_val = alpha_hash[letter] - 1
    { x: x_val, y: y_val }
  end

  def place_computer_ships(ship_lengths)
    ship_lengths.each do |len|
      start_coord, end_coord = {}, {}
      loop do
        start_coord = { x: rand(@computer_board.width), y: rand(@computer_board.height) }
        end_coord = @computer_board.get_possible_end_coords(start_coord, len).sample
        break unless end_coord == nil
      end
      @computer_board.add_ship(start_coord, end_coord)
    end
  end

  def print_board(person)
    if person == "Player 1"
      puts "Your game board", ""
      @printer_player.print_board
    elsif person == "Computer"
      puts "Enemy game board", ""
      @printer_comp.print_board
    else
      puts "Invalid printer"
    end
  end
end
