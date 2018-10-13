

class HTTPTranslator
  attr_reader :output
  HEADER = "=========================================
     Battleship Showdown: Sink or be Sunk
  ========================================="
  MESSAGE_START = "<html><p>" + HEADER + "</p><p>"
  STATUS = "http/1.1 200 ok"

  class << self

    def start_message
      @message = MESSAGE_START
    end

    def add_to_message(string)
      @message += string.sub("\n","</p><p>")
    end

    def give_message
      @message += "</p>"
    end

  end
end









  def respond
    accept_request
    send_response
    #wait_for_input
  end

  private
  def send_response
    puts "Sending response."
    response = @status + "\r\n\r\n" + @output + "</html>"
    @connection.puts response
    @connection.close
  end
  #
  # def server_loop
  #   loop do
  #     accept
  #
  #     send_to_local_program
  #     recieve_from_local_program
  #     form_response
  #     respond
  #   end
  # end

end
