require './lib/board.rb'
require './lib/printer.rb'
require './lib/guess.rb'
require 'pry'

class Game
  def initialize(options)
    board_width = options[:board_width]
    board_height = options[:board_height]
    ship_lengths = options[:ships]
    # a_i = options[:a_i]

    @player_fleet = Board.new(board_width, board_height)
    @enemy_fleet = Board.new(board_width, board_height)

    @printer = Printer.new

    place_computer_ships(ship_lengths)
    place_player_ships(ship_lengths)

    playing_loop
  end

  def playing_loop
    loop do
      player_round
      if @enemy_fleet.all_sunk?
        @printer.print_board(@enemy_fleet, false)
        puts "You have defeated the enemy!!!"
        break
      end
      enemy_round
      if @player_fleet.all_sunk?
        @printer.print_board(@player_fleet)
        puts "The enemy has defeated your fleet!"
        break
      end
    end
  end

  def player_round
    @printer.print_board(@enemy_fleet, false)
    puts "Enter coordinate of next strike (Ex. A3)"
    print "> "
    strike = $stdin.gets.chomp
    if strike == 'pry'
      binding.pry
    end
    if strike == "board"
      @printer.print_board(@enemy_fleet)
      binding.pry
    else
      coord = convert(strike)
      @enemy_fleet.guesses << Guess.new(@enemy_fleet, coord)
    end
  end

  def enemy_round
    x_coord = rand(@player_fleet.width) + 1
    y_coord = rand(@player_fleet.height) + 1
    coord = {x: x_coord, y: y_coord}
    @player_fleet.guesses << Guess.new(@player_fleet, coord)
    @printer.print_board(@player_fleet)
  end

  def place_player_ships(ship_lengths)
    # quick instuction
    ship_lengths.each do |len|
      @printer.print_board(@player_fleet)
      puts "Time to place a #{len} unit long ship"
      puts "Enter start coordinate (Ex. A3)"
      print "> "
      start_raw = $stdin.gets.chomp
      puts "Enter end coordinate (Ex. A5)"
      print "> "
      end_raw = $stdin.gets.chomp
      start_coord = convert(start_raw)
      end_coord = convert(end_raw)
      @player_fleet.add_ship(start_coord, end_coord)
    end
    puts "Ship placement complete:"
    @printer.print_board(@player_fleet)
  end

  def convert(raw)
    letter = raw[0].upcase
    x_val = raw[1..-1].to_i
    alpha_hash = ("A".."Z").zip(1..26).to_h
    y_val = alpha_hash[letter]
    { x: x_val, y: y_val }
  end

  def place_computer_ships(ship_lengths)
    ship_lengths.each do |len|
      start_coord, end_coord = {}, {}
      loop do
        start_coord = { x: rand(@enemy_fleet.width) + 1, y: rand(@enemy_fleet.height) + 1}
        end_coord = @enemy_fleet.get_possible_end_coords(start_coord, len).sample
        break unless end_coord == nil
      end
      @enemy_fleet.add_ship(start_coord, end_coord)
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

  def pf
    @player_fleet
  end
  def ef
    @enemy_fleet
  end
end
