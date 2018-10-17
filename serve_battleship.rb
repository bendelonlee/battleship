require './lib/interface'
require './lib/out'
require './lib/read'
require './lib/server'

Out.turn_online
Read.turn_online


battle_server = Server.new
battle_server.serve




# Interface.new
