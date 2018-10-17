require './lib/http_translator'
class Out
  @@online_mode = :offline

  class << self
    def turn_online
      @@online_mode = :online
    end
    def online?
      @@online_mode == :online
    end

    def put(str)
      if @@online_mode == :online
        http(str)
      else
        to_terminal(str)
      end
    end

    def put_n(str)
      put(str + "\n")
    end

    def http(str)
      HTTPTranslator.add_to_message(str)
    end

    def to_terminal(str)
      print(str)
    end

  end

end
