
require './lib/server'
class HTTPTranslator
  attr_reader :output
  STATUS = "http/1.1 200 ok"
  HEADER = "=========================================
  |  Battleship Showdown: Sink or be Sunk!  |
  =========================================".gsub("\n","</p><p>")
  CSS = "<style>.row {display: flex;}.column {flex: 50%;}</style>"

  FONT = '<font face="Courier" color="white">'
  BACKGROUND = '<body style="background-color:navy;">'
  ROW_COLUMN_SETUP = "<div class=\"row\"><div class=\"column\">"
  MESSAGE_START = STATUS + "\r\n\r\n" + "<html><center>" + CSS + BACKGROUND + FONT + "<p>" + HEADER + ROW_COLUMN_SETUP + "</p><p>"
  FORM = "<form> \
  INPUT:<br> \
  <input type=\"text\" name=\"input\"><br><br> \
  <input type=\"submit\" value=\"Submit\"> \
  </form>"
  NEW_COLUMN = "</div><div class=\"column\">"
  MESSAGE_CLOSE = "</p></div></div>" + FORM + "</center></font></body>'"
  @@message = ""

  class << self

    def start_message
      @@message = MESSAGE_START
    end

    def add_to_message(string)
      if string[//]
        puts ""
      end
      @@message += string.gsub("\n","</p><p>")
    end

    def give_message
      result = @@message + "<p> Game_id:#{Server.current_game_id}<p>" + MESSAGE_CLOSE 
      @@message = ""
      result
    end

    def has_message?
      @@message == ""? false : true
    end

    def show_message
      @@message
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
