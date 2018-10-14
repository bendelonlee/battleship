class Storage



  class << self
    def id_taken?(id)
    end

    def generate_id
      1
    end

    def game_ids
    end
    def save_game(game, game_id = nil)
      # return :id_taken if id_taken(game_id)
      #returns game id

      working_id = game_id ? game_id.to_s : generate_id
      File.write("./data/game_data/#{working_id}.data", Marshal.dump(game))
      # game.to_yaml

    end
    def load_game(game_id)
    end
  end
end
