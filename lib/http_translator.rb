
require 'pry'
class HTTPTranslator
  attr_reader :output
  STATUS = "http/1.1 200 ok"
  HEADER = "=========================================
           |  Battleship Showdown: Sink or be Sunk!  |
  =========================================".gsub("\n","</p><p>")
  FONT = '<font face="Courier" color="white">'
  BACKGROUND = '<body style="background-color:navy;">'
  MESSAGE_START = STATUS + "\r\n\r\n" + "<html>" + BACKGROUND + FONT + "<p>" + HEADER + "</p><p>"
  FORM = "<form> game:<br> <input type=\"text\" game=\"Hi\"><br> input:<br> <input type=\"text\" name=\"lastname\"> </form>"
  @@message = ""

  class << self

    def start_message
      @@message = MESSAGE_START
    end

    def add_to_message(string)
      @@message += string.gsub("\n","</p><p>")
    end

    def give_message
      result = @@message += "</p>" + FORM + "</font></body>'"
      @@message = ""
      result
    end

    def has_message?
      @@message == ""? false : true
    end

  end
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
