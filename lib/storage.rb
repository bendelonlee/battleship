class Storage



  class << self
    def list_of_saves
      Dir["./data/game_data/*"].join.scan(/\w+(?=\.data)/)
    end

    def new_id
      i = 1
      loop do
        i += 1
        return i.to_s unless list_of_saves.include?(i.to_s)
      end
    end


    def save_game(game = Game.current_game, game_id = nil)

      if caller.join[/get_valid_start_coord/]
        Game.current_game.when_in_placement = :needs_start_coord
      elsif caller.join[/get_valid_end_coord/]

        Game.current_game.when_in_placement = :needs_end_coord
      end

      # return :id_taken if id_taken(game_id)
      #returns game id

      working_id = game_id ? game_id.to_s : Storage.new_id
      File.write("./data/game_data/#{working_id}.data", Marshal.dump(game))
      # game.to_yaml

    end
    def load_game(game_id)
      game_data = File.open("./data/game_data/#{game_id}.data", 'r')
      Marshal.load(game_data)
    end
    def load_and_run_game(game_id, user_input = nil)
      Read.preload([user_input]) if user_input
      loaded_game = Game.set_current_game(Storage.load_game(game_id))
      if loaded_game.when_in_placement
        loaded_game.play
        return loaded_game
      else
        loaded_game.playing_loop
        return loaded_game
      end
    end

  end
end
