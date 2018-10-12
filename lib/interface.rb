require './lib/game.rb'

class Interface
  def initialize
    @options = { board_width: 4, board_height: 4, ships: [2, 3], a_i: false,
                time_delay: 0, player_1: :person1, player_2: :person2} #:person2, :computer1
    puts "========================================="
    puts "   Welcome to the Battleship showdown!"
    puts "========================================="
    interface_loop
  end

  def interface_loop
    while true
      puts "Would you like to (p)lay, read the (i)instructions, change the (o)ptions, or (q)uit?"
      print "> "

      user_input = $stdin.gets.chomp

      case user_input
      when "p"
        start_time = Time.now
        game = Game.new(@options)
        game.play
        end_time = Time.now
        total_time = (end_time - start_time).to_i
        puts "This game took #{total_time / 60} minutes and #{((end_time - start_time) % 60).round(4)} seconds."
        puts "========================================"
      when "i"
        instructions
      when "o"
        change_options
      when "q"
        return
      end
    end
  end

  def instructions
    puts "===================", "Kill their battleship."
    puts "Don't let them kill you.", "==================="
  end

  def change_options
    change_x
    change_y
    change_ships
    change_ai
    puts "Options updated", ""
  end

  def change_x
    puts "What size board do you want in X? Valid sizes 4-26"
    print "> "
    new_x = $stdin.gets.chomp.to_i
    if new_x > 26 || new_x < 4
      puts "Invalid option. Option skipped."
    else
      @options[:board_width] = new_x
    end
  end

  def change_y
    puts "What size board do you want in Y? Valid sizes 4-26"
    print "> "
    new_y = $stdin.gets.chomp.to_i
    if new_y > 26 || new_y < 4
      puts "Invalid option. Option skipped."
    else
      @options[:board_height] = new_y
    end
  end

  def change_ai
    puts "Do you want AI? (y/n)"
    a_i = $stdin.gets.chomp
    if a_i == "y"
      @options[:a_i] = true
    elsif a_i == "n"
      @options[:a_i] = false
    else
      puts "Invalid option. Option skipped."
    end
  end

  def change_ships
    puts "Enter lengths of ships one by one. Press (q) when finished"
    finished = false
    ship_count = 0
    ships = []
    until finished == true
      ship_count += 1
      puts "Enter length for ship #{ship_count}"
      print "> "
      ship_length = $stdin.gets.chomp.to_i
      if ship_length == 0
        finished = true
      else
        ships << ship_length
      end
    end
    @options[:ships] = ships
  end
end
