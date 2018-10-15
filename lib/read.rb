require "./lib/battle_server"

class Read
  @@preloaded_input =[]
  @@online_mode = :offline
  class << self
    def turn_online
      @@online_mode = :online
    end

    def preload(arr)
      @@preloaded_input = arr
    end

    def check_for_commands(input)
      if input == 'pry'
        require 'pry'; binding.pry
        return resume_playing
      elsif input == 'save' && Game.current_game
        Out.put_n "What do you want to call your game?"
        game_id = self.in
        Storage.save_game(Game.current_game, game_id)
        return resume_playing
      elsif input == 'load'
        Out.put_n "What is the id or name of the game you want to load?"
        game_id = self.in
        Storage.load_and_run_game(game_id)
      end
      input
    end

    def resume_playing
      Out.put_n "Resume playing:"
      return self.in
    end

    def in
      unless @@preloaded_input.empty?
        puts "preloaded input:#{@@preloaded_input[0]}"
        return check_for_commands(@@preloaded_input.shift)
      end
      if @@online_mode == :online
        return check_for_commands(http)
      else
        return check_for_commands(gets.chomp)
      end
    end




    def http
      BattleServer.send_response_and_return_input
    end

  end
end
