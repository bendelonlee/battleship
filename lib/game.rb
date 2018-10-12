require './lib/board.rb'
require './lib/printer.rb'
require './lib/guess.rb'
require 'pry'

class Game
  def initialize(options = nil)
    return unless options
    @player_fleet = Board.new(options[:board_width], options[:board_height])
    @enemy_fleet = Board.new(options[:board_width], options[:board_height])
    @printer = Printer.new(options[:board_width], options[:board_height])
    @options = options
  end

  def play
    place_ships
    playing_loop
  end

  def place_ships
    ship_lengths = @options[:ships]
    place_computer_ships(ship_lengths)
    place_player_ships(ship_lengths)
  end

  def playing_loop
    total_shots = 0
    until game_over?
      total_shots % 2 == 0 ? player_round : enemy_round
      total_shots += 1
      if game_over?
        total_shots % 2 == 0 ? winner_message("enemy") : winner_message("player")
      end
    end
  end

  def game_over?
    if @enemy_fleet.all_sunk?
      winner_message("player")
      return true
    elsif @player_fleet.all_sunk?
      winner_message("enemy")
      return true
    end
    false
  end

  def winner_message(winner)  #change player/enemy to symbols
    if winner == "player"
      print_enemy
      puts "You have defeated the enemy!!!"
      puts "It took you #{@enemy_fleet.guesses.count} shots to find glory!"
    else
      print_player
      puts "The enemy has defeated your fleet!"
      puts "It took them #{@enemy_fleet.guesses.count} shots to murder your fleet."
    end
  end

  def player_round
    print_enemy
    coord = get_guess_coord
    sunk_ships_before = @enemy_fleet.ships.count { |ship| ship.sunk? }
    @enemy_fleet.add_guess(coord)
    sunk_ships_after = @enemy_fleet.ships.count { |ship| ship.sunk? }
    print_enemy
    @enemy_fleet.guesses.last.hit ? (print "You hit a ship!!!\n\n") : (print "You missed!\n\n")
    if sunk_ships_before != sunk_ships_after
      puts "You sunk a ship!\n\n\n"
    end
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

  def print_enemy
    @printer.print_board(@enemy_fleet, false)
    puts "Enemy fleet"
  end

  def print_player
    @printer.print_board(@player_fleet)
    puts "Player fleet"
  end

  def enemy_round
    x_coord, y_coord = rand(@player_fleet.width) + 1, rand(@player_fleet.height) + 1
    coord = {x: x_coord, y: y_coord}
    sunk_ships_before = @player_fleet.ships.count { |ship| ship.sunk? }
    @player_fleet.guesses << Guess.new(@player_fleet, coord)
    sunk_ships_after = @player_fleet.ships.count { |ship| ship.sunk? }
    print_player
    print "The enemy shot at #{CoordMath.xy_to_alpha_num(coord)}. "
    @player_fleet.guesses.last.hit ? (print "The enemy hit your ship!!!\n\n") : (print "The enemy missed!\n\n")
    if sunk_ships_before != sunk_ships_after
      puts "The enemy sunk your ship!\n\n\n"
    end
    puts "<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>"
  end

  def place_player_ships(ship_lengths)
    ship_lengths.each do |len|
      print_player
      start_coord = get_valid_start_coord(@player_fleet, len)
      print_player
      end_coord = get_valid_end_coord(@player_fleet, start_coord, len)
      @player_fleet.add_ship(start_coord, end_coord)
    end
    puts "Ship placement complete:"
    print_player
    print "\n\n"
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

end
