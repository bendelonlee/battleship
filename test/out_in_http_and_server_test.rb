require 'minitest/autorun'
require 'minitest/pride'
require './lib/out.rb'
require './lib/read.rb'
require './lib/battle_server.rb'
require './lib/http_translator.rb'



class InOutHTTPAndServerTest < Minitest::Test
  def test_integration
    # Out.turn_online
    # Read.turn_online
    # Out.put_n "
    # =====================
    # . 1 2 3 4 5 6 7 8 9 10
    #
    # A ~ ~ 3 3 3 3 ~ ~ ~ ~
    # B 1 1 1 1 1 ~ ~ ~ 8 8
    # C ~ ~ ~ ~ ~ ~ 6 ~ ~ ~
    # D ~ ~ ~ ~ ~ ~ 6 ~ ~ ~
    # ====================="
    # input = Read.in
    # assert_equal "something", input
    #test only works if you type http://localhost:9292/?something into your browser
  end


end
