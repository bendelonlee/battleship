class Storage



  class << self
    def id_taken?(id)
    end

    def generate_id
      1
    end

    def game_ids
    end
    def save_game(game = Game.current_game, game_id = nil)
      if caller[3..7].join[/get_valid_start_coord/]
        Game.current_game.pause_location = :ship_placement_start_coord
      elsif caller[3..7].join[/get_valid_end_coord/]

        Game.current_game.pause_location = :ship_placement_end_coord
      end

      # return :id_taken if id_taken(game_id)
      #returns game id

      working_id = game_id ? game_id.to_s : generate_id
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
      if loaded_game.pause_location == :ship_placement_start_coord
        loaded_game.place_ships_now
        return loaded_game
      elsif loaded_game.pause_location == :ship_placement_end_coord
        pause_info = true
        loaded_game.place_ships_now(loaded_game.temp_start_coord)
        return loaded_game
      else
        loaded_game.playing_loop
        return loaded_game
      end
    end

  end
end
