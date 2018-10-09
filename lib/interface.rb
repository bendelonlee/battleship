class Interface
  def initialize
    @options = { board_x: 4, board_y: 4, a_i: false }
    puts "Welcome to BATTLESHIP!", ""
    interface_loop
  end

  def interface_loop
    while true
      puts "Would you like to (p)lay, read the (i)instructions, change the (o)ptions, or (q)uit?"
      print "> "

      user_input = $stdin.gets.chomp

      case user_input
      when "p"
        Game.new(@options)
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
    puts "", "Kill their battleship."
    puts "Don't let them kill you.", ""
  end

  def change_options
    change_x
    change_y
    change_ai
  end

  def change_x
    puts "What size board do you want in X? Valid sizes 4-26"
    print "> "
    new_x = $stdin.gets.chomp.to_i
    if new_x > 26 || new_x < 4
      puts "Invalid option. Option skipped."
    else
      @options[:board_x] = new_x
    end
  end

  def change_y
    puts "What size board do you want in Y? Valid sizes 4-26"
    print "> "
    new_y = $stdin.gets.chomp.to_i
    if new_y > 26 || new_y < 4
      puts "Invalid option. Option skipped."
    else
      @options[:board_y] = new_y
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

end
