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
        self.in
      end
      input
    end

    def in
      unless @@preloaded_input.empty?
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
