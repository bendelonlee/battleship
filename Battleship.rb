require './lib/interface'
require './lib/read'
require './lib/storage'
require 'pry'


list_of_entries = ['p', 'b2', 'b6', 'd3', 'd6']
# list_of_entries2 =['load']

list_of_entries3 = ['p', 'b2', 'b6', 'd3', 'd6', 'b9']
list_of_entries4 = ['p', 'b2', 'save', 'mid_placement', 'load', 'mid_placement']
list_of_entries5 = ['p', 'b2', 'save', 'mid_placement', 'load', 'mid_placement']
list6 = [['load', '8', 'a2', 'a6', 'a7', 'a10', 'b2', 'b4', 'e1']]
list = %w(p a1 a5 b1 b4 c1 c3 d1)
Read.preload([])
Read.preload(%w(p a1 a5 b1 b4 c1 c3 d1 save almost_all_placed))
# Read.preload(['o'])
# Read.preload(%w(o 4 4 3 2 q n))
# Read.preload(%w(load almost_all_placed))29
# Read.preload(['p','A1', 'A5', 'save', 'placed_one_ship'])


interface = Interface.new
interface.interface_loop
