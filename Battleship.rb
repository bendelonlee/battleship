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
Read.preload(%w(p load placed_one_ship))
# Read.preload(['p','A1', 'A5', 'save', 'placed_one_ship'])


interface = Interface.new
interface.interface_loop
