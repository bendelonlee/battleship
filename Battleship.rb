require './lib/interface'
require './lib/read'
require './lib/storage'


list_of_entries = ['p', 'b2', 'b6', 'd3', 'd6', 'save', 'mid_placement', 'load', 'mid_placement']
list_of_entries2 =['load']
list_of_entries3 = ['p', 'b2', 'b6', 'd3', 'd6', 'b9', 'save', 'mid_placement', 'load', 'mid_placement']

Read.preload(list_of_entries3)


Interface.new
