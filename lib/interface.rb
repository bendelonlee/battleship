require './lib/string'
require './lib/game'
require './lib/read'
require './lib/out'

class Interface
  DEFAULT_OPTIONS = { board_width: 10, board_height: 5, ships: [5,4,3,2], a_i: true,
              time_delay: 0.5, player_1: :person1, player_2: :computer2,
            output: true}

  def initialize

    @options = DEFAULT_OPTIONS
    Out.put_n "========================================="
    Out.put_n "   Welcome to the Battleship showdown!"
    Out.put_n "========================================="
  end

  def interface_loop

    while true
      Out.put_n "Would you like to (p)lay, read the (i)instructions, change the (o)ptions, or (q)uit?"
      Out.put "> "

      user_input = Read.in; return user_input if user_input == :return_to_server


      case user_input
      when "p"
        start_time = Time.now
        game = Game.new(@options)
        game.play
        end_time = Time.now
        total_time = (end_time - start_time).to_i
        Out.put_n "This game took #{total_time / 60} minutes and #{((end_time - start_time) % 60).round(4)} seconds."
        Out.put_n "========================================"
      when "i"
        instructions
      when "o"
        change_options

      when "q"
        return # class.quit_interface(nil)
      end

    end
  end

  # def self.quit_interface(return_value)
  #   return return_value
  # end

  def instructions
    Out.put_n "===================\nKill their battleship."
    Out.put_n "Don't let them kill you.\n==================="
  end

  def change_options
    change_x
    change_y
    change_ships
    change_ai
    Out.put_n "Options updated\n"
  end

  def change_x
    Out.put_n "What size board do you want in X? Valid sizes 4-26"
    Out.put "> "
    new_x = Read.in; return new_x if new_x == :return_to_server
    new_x = new_x.to_i
    if new_x > 26 || new_x < 4
      Out.put_n "Invalid option. Option skipped."
    else
      @options[:board_width] = new_x
    end
  end

  def change_y
    Out.put_n "What size board do you want in Y? Valid sizes 4-26"
    Out.put "> "
    new_y = Read.in; return new_y if new_y == :return_to_server
    new_y = new_y.to_i
    if new_y > 26 || new_y < 4
      Out.put_n "Invalid option. Option skipped."
    else
      @options[:board_height] = new_y
    end
  end

  def change_ai
    Out.put_n "Do you want AI? (y/n)"
    a_i = Read.in; return a_i if a_i == :return_to_server
    if a_i == "y"
      @options[:a_i] = true
    elsif a_i == "n"
      @options[:a_i] = false
    else
      Out.put_n "Invalid option. Option skipped."
    end
  end

  def change_ships
    Out.put_n "Enter lengths of ships one by one. Press (q) when finished"
    finished = false
    ship_count = 0
    ships = []
    until finished == true
      ship_count += 1
      Out.put_n "Enter length for ship #{ship_count}"
      Out.put "> "
      ship_lengths = Read.in;
      return ship_lengths if ship_lengths == :return_to_server
      ship_lengths = ship_lengths.to_i
      if ship_lengths == 0
        finished = true
      else
        ships << ship_lengths
      end
    end
    @options[:ships] = ships
  end
end
