require 'socket'
require './lib/http_translator'

class BattleServer

  class << self

    def send_response_and_return_input

      connection = wait_for_request
      request_line = accept_request(connection)
      input = process_request(request_line)
      #process_request evaluates messages and sends it where it's supposed go
      deliver_response(connection)
      close_connection(connection)
      input
    end


    def wait_for_request
      $stdout = STDOUT
      puts "Waiting for Request..."
      server = TCPServer.new(9292)
      connection = server.accept
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
      request_line[/(?<=\?)\w+/]
    end

    def deliver_response(connection)
      connection.puts HTTPTranslator.give_message
    end

    def close_connection(connection)
      connection.close
    end

  end
end
