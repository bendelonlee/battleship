require 'socket'
require './lib/http_translator'
require './lib/interface'
require './lib/storage'

class Server

  @@current_game_id = nil

  def initialize
    @server = TCPServer.new(9293)
  end

  def self.current_game_id
    @@current_game_id
  end


  def serve

    loop do
      connection = wait_for_request
      request_line = accept_request(connection)
      next unless request_line

      game_id, user_input, new_game = process_request(request_line)
      if new_game
        game = start_new_game
        game.when_in_placement = :needs_start_coord
        game_id = Storage.new_id
      else
        game = give_game_input(game_id, user_input) if game_id && user_input
      end

      @@current_game_id = game_id
      #now the game runs. It delivers it's output of to the HTTPTranslator class until it needs more input, then returns
      store_game_data(game, game_id) if game.is_a? Game
      deliver_response(connection)

      # binding.pry
      close_connection(connection)
    end
  end



  def start_new_game
    new_game = Game.new(Interface::DEFAULT_OPTIONS)
    new_game.play
    new_game
  end

  def give_game_input(game_id, user_input)
    Storage.load_and_run_game(game_id, user_input)
  end

  def store_game_data(game, game_id)
    Storage.save_game(game, game_id)
  end


  def wait_for_request
    puts "Waiting for Request..."
    @server.accept
  end

  def accept_request(connection)
    puts "Got this request:"
    request_lines = []
    line = connection.gets
    return nil unless line
    line = line.chomp
    #added line above because sometimes line is nil

    until line.empty?
      request_lines << line
      line = connection.gets.chomp
    end
    puts request_lines
    request_lines[0]
  end

  def process_request(request_line)
    game_id = request_line[/(?<=game=)\w+/]
    user_input = request_line[/(?<=input=)\w+/]
    new_game = request_line[/\?new_game/] ? true : false
    [game_id, user_input, new_game]
  end

  def deliver_response(connection)
    connection.puts HTTPTranslator.give_message
  end

  def close_connection(connection)
    connection.close
  end

end
