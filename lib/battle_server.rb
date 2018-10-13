require 'socket'
require './lib/http_translator'

class BattleServer
  @@server = TCPServer.new(9292)
  @@input = ''

  class << self

    def send_response_and_return_input

      2.times do
        connection = wait_for_request
        request_line = accept_request(connection)
        process_request(request_line)
        #process_request evaluates messages and sends it where it's supposed go
        deliver_response(connection)
        close_connection(connection)
      end
      @@input
    end


    def wait_for_request
      puts "Waiting for Request..."
      connection = @@server.accept
    end

    def accept_request(connection)
      puts "Got this request:"
      request_lines = []
      line = connection.gets.chomp
      until line.empty?
        request_lines << line
        line = connection.gets.chomp
      end
      puts request_lines
      request_lines[0]
    end

    def process_request(request_line)
      input = request_line[/(?<=\?)\w+/]
      @@input = input if input
    end

    def deliver_response(connection)
      connection.puts HTTPTranslator.give_message
    end

    def close_connection(connection)
      connection.close
    end

  end
end
