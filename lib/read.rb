require "./lib/battle_server"

class Read
  @@online_mode = :offline
  class << self
    def turn_online
      @@online_mode = :online
    end

    def in
      if @@online_mode == :online
        http
      else
        gets.chomp
      end
    end

    def http
      BattleServer.send_response_and_return_input
    end

  end
end
