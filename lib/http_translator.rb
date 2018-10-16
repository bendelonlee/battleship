
require 'pry'
class HTTPTranslator
  attr_reader :output
  STATUS = "http/1.1 200 ok"
  HEADER = "=========================================
  |  Battleship Showdown: Sink or be Sunk!  |
  =========================================".gsub("\n","</p><p>")
  FONT = '<font face="Courier" color="white">'
  BACKGROUND = '<body style="background-color:navy;">'
  MESSAGE_START = STATUS + "\r\n\r\n" + "<html><center>" + BACKGROUND + FONT + "<p>" + HEADER + "</p><p>"
  FORM = "<form>
  GAME:<br>
  <input type=\"text\" name=\"game\" value=\"77\"><br>
  INPUT:<br>
  <input type=\"text\" name=\"input\" value=\"a1\"><br><br>
  <input type=\"submit\" value=\"Submit\">
  </form>"
  @@message = ""

  class << self

    def start_message
      @@message = MESSAGE_START
    end

    def add_to_message(string)
      if string[//]
        puts caller
        puts ""
      end
      @@message += string.gsub("\n","</p><p>")
    end

    def give_message
      result = @@message += "</p>" + FORM + "</center></font></body>'"
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
