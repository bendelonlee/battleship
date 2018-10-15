require './lib/interface'
require './lib/out'
require './lib/read'

Out.turn_online
Read.turn_online


interface = Interface.new
p interface.interface_loop
require 'pry'; binding.pry




# Interface.new
