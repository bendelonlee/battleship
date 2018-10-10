require './lib/board.rb'
require './lib/printer.rb'
require './lib/guess.rb'
require 'pry'

class Game
  def initialize(options)
    @player_fleet = Board.new(options[:board_width], options[:board_height])
    @enemy_fleet = Board.new(options[:board_width], options[:board_height])
    @printer = Printer.new
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
        winner_message
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

  def winner_message(winner)
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
    puts "Enter coordinate of next strike (Ex. A3)"
    print "> "
    strike = $stdin.gets.chomp
    if strike == "board"
      @printer.print_board(@enemy_fleet)
      binding.pry
    else
      coord = n_to_c(strike)
      sunk_ships_before = @enemy_fleet.ships.count { |ship| ship.sunk? }
      @enemy_fleet.add_guess(coord)
      sunk_ships_after = @enemy_fleet.ships.count { |ship| ship.sunk? }
      @enemy_fleet.guesses.last.hit ? (print "HIT!!!\n") : (print "Miss!\n")
      if sunk_ships_before != sunk_ships_after
        puts "You sunk a ship!"
      end
      # add hit/miss dialog; add if it sinks a ship
    end
  end

  def print_enemy
    @printer.print_board(@enemy_fleet, false)
    puts "Enemy fleet", ""
  end

  def print_player
    @printer.print_board(@player_fleet)
    puts "Player fleet", ""
  end

  def enemy_round
    x_coord = rand(@player_fleet.width) + 1
    y_coord = rand(@player_fleet.height) + 1
    coord = {x: x_coord, y: y_coord}
    sunk_ships_before = @player_fleet.ships.count { |ship| ship.sunk? }
    @player_fleet.guesses << Guess.new(@player_fleet, coord)
    sunk_ships_after = @player_fleet.ships.count { |ship| ship.sunk? }
    print_player
    print "The enemy shot at #{c_to_n(coord)}. "
    @player_fleet.guesses.last.hit ? (print "HIT!!!\n") : (print "Miss!\n")
    if sunk_ships_before != sunk_ships_after
      puts "The enemy sunk your ship!"
    end
    # add hit/miss dialong along with computer shot location; add if it sinks a ship
  end

  def place_player_ships(ship_lengths)
    # quick instuction
    ship_lengths.each do |len|
      print_player
      puts "Time to place a #{len} unit long ship"
      puts "Enter start coordinate (Ex. A3)"
      print "> "
      start_raw = $stdin.gets.chomp
      puts "Enter end coordinate (Ex. A5)"
      print "> "
      end_raw = $stdin.gets.chomp
      start_coord = n_to_c(start_raw)
      end_coord = n_to_c(end_raw)
      @player_fleet.add_ship(start_coord, end_coord)
    end
    puts "Ship placement complete:"
    print_player
  end

  def n_to_c(raw)
    letter = raw[0].upcase
    x_val = raw[1..-1].to_i
    alpha_hash = ("A".."Z").zip(1..26).to_h
    y_val = alpha_hash[letter]
    { x: x_val, y: y_val }
  end

  def c_to_n(coord)
    alpha_hash = (1..26).zip("A".."Z").to_h
    letter = alpha_hash[coord[:y]]
    number = coord[:x].to_s
    letter + number
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

  #### delete if no errors after some tests
  # def print_board(person)
  #   if person == "Player 1"
  #     puts "Your game board", ""
  #     @printer_player.print_board
  #   elsif person == "Computer"
  #     puts "Enemy game board", ""
  #     @printer_comp.print_board
  #   else
  #     puts "Invalid printer"
  #   end
  # end

  def pf
    @player_fleet
  end
  def ef
    @enemy_fleet
  end
end
