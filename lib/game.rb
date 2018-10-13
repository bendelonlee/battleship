require './lib/board.rb'
require './lib/printer.rb'
require './lib/guess.rb'
require 'pry'

class Game
  attr_reader :winner_data

  def initialize(options = nil)
    return unless options
    @player_fleet = Board.new(options[:board_width], options[:board_height])
    @enemy_fleet = Board.new(options[:board_width], options[:board_height])
    @printer = Printer.new(options[:board_width], options[:board_height])
    @options = options
    @ship_lengths = @options[:ships]
    @player_1 = @options[:player_1]
    @player_2 = @options[:player_2]
  end

  def delay
    sleep(@options[:time_delay])
  end

  def play
    place_ships_now
    playing_loop
    return @winner_data
  end

  def place_ships_now
    ship_lengths = @ship_lengths
    place_ships(ship_lengths, @player_1)
    place_ships(ship_lengths, @player_2)
  end

  def playing_loop
    total_shots = 0
    until game_over?
      total_shots % 2 == 0 ? play_round(@player_1) : play_round(@player_2)
      total_shots += 1
    end
  end

  def game_over?
    if @enemy_fleet.all_sunk?
      @winner_data = {winner: 1, shots: @enemy_fleet.guesses.count}
      winner_message(:player) if @options[:output] == true
      return true
    elsif @player_fleet.all_sunk?
      @winner_data = {winner: 2, shots: @enemy_fleet.guesses.count}
      winner_message(:player_2) if @options[:output] == true
      return true
    end
    false
  end

  def winner_message(winner)  #change player/enemy to symbols
    if winner == :player
      print_board(@enemy_fleet, true)
      puts "Player 1 has defeated the enemy!!!"
      puts "It took player 1 #{@enemy_fleet.guesses.count} shots to find glory!"
    else
      print_board(@player_fleet, true)
      puts "Player 2 has defeated its enemy!"
      puts "It took player 2 #{@player_fleet.guesses.count} shots to murder the enemy's fleet."
    end
  end

  def play_round(player)
    if player == :person1 || player == :person2
      player == :person1 ? fleet = @enemy_fleet : fleet = @player_fleet
      print_board(fleet, false) if @options[:output] == true
      coord = get_guess_coord
      sunk_ships_before = fleet.ships.count { |ship| ship.sunk? }
      fleet.add_guess(coord)
      sunk_ships_after = fleet.ships.count { |ship| ship.sunk? }
      print_board(fleet, false) if @options[:output] == true
      delay
      if @options[:output] == true
        fleet.guesses.last.hit ? (print "Player hit a ship!!!\n\n") : (print "Player missed!\n\n")
      end
      if sunk_ships_before != sunk_ships_after && @options[:output] == true
        puts "Player sunk a ship!\n\n\n"
      end
      delay
    else
      player == :computer2 ? fleet = @player_fleet : fleet = @enemy_fleet
      loop do
        x_coord, y_coord = rand(fleet.width) + 1, rand(fleet.height) + 1
        coord = {x: x_coord, y: y_coord}
        break if unguessed?(fleet, coord)
      end
      print_board(fleet, true) if @options[:output] == true
      delay
      sunk_ships_before = fleet.ships.count { |ship| ship.sunk? }
      fleet.guesses << Guess.new(fleet, coord)
      sunk_ships_after = fleet.ships.count { |ship| ship.sunk? }
      print_board(fleet, true) if @options[:output] == true
      delay
      if @options[:output] == true
        print "The enemy shot at #{CoordMath.xy_to_alpha_num(coord)}. "
        fleet.guesses.last.hit ? (print "The enemy hit a ship!!!\n\n") : (print "The enemy missed!\n\n")
        if sunk_ships_before != sunk_ships_after
          puts "The enemy sunk a ship!\n\n\n"
        end
      end
      delay
    end
    puts "<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>" if @options[:output] == true
  end

  def get_guess_coord
    coord = get_coord("Enter coordinate of next strike (Ex. A3)")
    return coord if unguessed?(@enemy_fleet, coord) \
            && CoordMath.coord_in_board?(@enemy_fleet, coord)
    get_guess_coord
  end

  def unguessed?(board, coord)
    board.guesses.none?{|g| g.coord == coord}
  end

  def print_board(fleet, print_ships = true)
    @printer.print_board(fleet, print_ships)
    fleet == @player_fleet ? player_num = 1 : player_num = 2
    puts "Player #{player_num} fleet"
  end

  def place_ships(ship_lengths, player)
    if player == :person1 || player == :person2
      player == :person1 ? fleet = @player_fleet : fleet = @enemy_fleet
      ship_lengths.each do |len|
        print_board(fleet, true)
        start_coord = get_valid_start_coord(fleet, len)
        print_board(fleet, true)
        end_coord = get_valid_end_coord(fleet, start_coord, len)
        fleet.add_ship(start_coord, end_coord)
      end
      puts "Ship placement complete:"
      print_board(fleet, true)
      print "\n\n"
    else
      player == :computer2 ? fleet = @enemy_fleet : fleet = @player_fleet
        ship_lengths.each do |len|
          start_coord, end_coord = {}, {}
          loop do
            start_coord = { x: rand(fleet.width) + 1, y: rand(fleet.height) + 1}
            end_coord = fleet.get_possible_end_coords(start_coord, len).sample
            break unless end_coord == nil
          end
          fleet.add_ship(start_coord, end_coord)
        end
    end
  end

  def get_valid_start_coord(board, ship_len)
    puts "Time to place a #{ship_len} unit long ship"
    puts "Enter start coordinate (Ex. A3)"
    start_coord = get_coord
    return start_coord if board.valid_start?(start_coord, ship_len)
    puts "Invalid coordinate."
    get_valid_start_coord(board, ship_len)
  end

  def get_valid_end_coord(board, start_coord, ship_len)
    possible_coords = board.get_possible_end_coords(start_coord, ship_len)
    puts "Enter end coordinate. Options:"
    puts CoordMath.coords_to_s(possible_coords)
    end_coord = get_coord
    if possible_coords.include?(end_coord)
      return end_coord
    end
    puts "Invalid coordinate. Ship must be in an orthogonal line #{ship_len} units long."
    get_valid_end_coord(board, start_coord, ship_len)
  end

  def get_coord(ask = nil)
    puts ask if ask
    print "> "; str = gets.chomp
    if CoordMath.is_alpha_number?(str)
      return CoordMath.alpha_num_to_xy(str)
    else
      puts "Invalid input."
      get_coord
    end
  end

end
