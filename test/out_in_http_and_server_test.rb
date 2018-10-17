require 'minitest/autorun'
require 'minitest/pride'
require './lib/out.rb'
require './lib/read.rb'
require './lib/http_translator.rb'



class InOutHTTPAndServerTest < Minitest::Test
  def setup
    Read.turn_online
    Out.turn_online

  end
  def teardown
    HTTPTranslator.start_message
  end
  def help_set_up_game
    @game = Game.new
    @game.play
  end
  def test_it_can_start_a_game
    help_set_up_game
    expected = "http/1.1 200 ok\r\n\r\n<html><center><style>.row {display: flex;}.column {flex: 50%;}</style><body style=\"background-color:navy;\"><font face=\"Courier\" color=\"white\"><p>=========================================</p><p>  |  Battleship Showdown: Sink or be Sunk!  |</p><p>  =========================================<div class=\"row\"><div class=\"column\"></p><p>Player 1 fleet</p><p>=====================</p><p>. 1 2 3 4 5 6 7 8 9 10</p><p>A ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>B ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>C ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>D ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>E ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>=====================</p><p></div><div class=\"column\">Time to place a 5 unit long ship</p><p>Enter start coordinate (Ex. A3)</p><p>> <p> Game_id:<p></p></div></div><form>   INPUT:<br>   <input type=\"text\" name=\"input\"><br><br>   <input type=\"submit\" value=\"Submit\">   </form></center></font></body>'"
    assert_equal expected, HTTPTranslator.give_message
  end

  def test_it_can_let_user_set_up_ships
    Read.preload(['b2', 'b6', 'd3', 'd6', 'b9', 'b7', 'e8', 'd8'])
    help_set_up_game
    expected = "http/1.1 200 ok\r\n\r\n<html><center><style>.row {display: flex;}.column {flex: 50%;}</style><body style=\"background-color:navy;\"><font face=\"Courier\" color=\"white\"><p>=========================================</p><p>  |  Battleship Showdown: Sink or be Sunk!  |</p><p>  =========================================<div class=\"row\"><div class=\"column\"></p><p>Ship placement complete:</p><p>Player 1 fleet</p><p>=====================</p><p>. 1 2 3 4 5 6 7 8 9 10</p><p>A ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>B ~ 1 1 1 1 1 3 3 3 ~</p><p>C ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>D ~ ~ 2 2 2 2 ~ 4 ~ ~</p><p>E ~ ~ ~ ~ ~ ~ ~ 4 ~ ~</p><p>=====================</p><p></div><div class=\"column\"></p><p></p><p>Player 2 fleet</p><p>=====================</p><p>. 1 2 3 4 5 6 7 8 9 10</p><p>A ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>B ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>C ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>D ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>E ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>=====================</p><p></div><div class=\"column\">Enter coordinate of next strike (Ex. A3)</p><p>> <p> Game_id:<p></p></div></div><form>   INPUT:<br>   <input type=\"text\" name=\"input\"><br><br>   <input type=\"submit\" value=\"Submit\">   </form></center></font></body>'"
    assert_equal expected, HTTPTranslator.give_message
  end

  def test_it_can_save_game_mid_setup
    Read.preload(['b2', 'b6', 'd3', 'd6', 'b9', 'b7', 'e8', 'save', 'almost_completely_placed'])
    help_set_up_game
    expected = "http/1.1 200 ok\r
\r
<html><center><style>.row {display: flex;}.column {flex: 50%;}</style><body style=\"background-color:navy;\"><font face=\"Courier\" color=\"white\"><p>=========================================</p><p>  |  Battleship Showdown: Sink or be Sunk!  |</p><p>  =========================================<div class=\"row\"><div class=\"column\"></p><p>Resume playing:</p><p><p> Game_id:<p></p></div></div><form>   INPUT:<br>   <input type=\"text\" name=\"input\"><br><br>   <input type=\"submit\" value=\"Submit\">   </form></center></font></body>'"
    assert_equal expected, HTTPTranslator.give_message
  end

  def test_it_can_load_a_game_mid_setup
    skip
    Read.preload(['load', 'almost_completely_placed','d8'])
    interface = Interface.new
#     expected = "http/1.1 200 ok\r
# \r
# <html><center><style>.row {display: flex;}.column {flex: 50%;}</style><body style=\"background-color:navy;\"><font face=\"Courier\" color=\"white\"><p>=========================================</p><p>  |  Battleship Showdown: Sink or be Sunk!  |</p><p>  =========================================<div class=\"row\"><div class=\"column\"></p><p>Player 1 fleet</p><p>=====================</p><p>. 1 2 3 4 5 6 7 8 9 10</p><p>A ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>B ~ 1 1 1 1 1 3 3 3 ~</p><p>C ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>D ~ ~ 2 2 2 2 ~ ~ ~ ~</p><p>E ~ ~ ~ ~ ~ ~ ~ ~ ~ ~</p><p>=====================</p><p></div><div class=\"column\">Invalid coordinate.</p><p>Time to place a 5 unit long ship</p><p>Enter start coordinate (Ex. A3)</p><p>> Invalid input 'load'.</p><p>> <p> Game_id:<p></p></div></div><form>   INPUT:<br>   <input type=\"text\" name=\"input\"><br><br>   <input type=\"submit\" value=\"Submit\">   </form></center></font></body>'"
    assert_equal "", HTTPTranslator.give_message

  end




end
