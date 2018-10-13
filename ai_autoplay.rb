require './lib/game.rb'
require 'pry'

options = { board_width: 10, board_height: 10, ships: [5, 4, 3, 2, 2], a_i: true,
            time_delay: 0, player_1: :computer1, player_2: :computer2}

ai_notes = "If last guess had a hit, guess an adjacent square if not hit already."

game_data = []
times_to_run = 1000
start_time = Time.now

times_to_run.times {
  game = Game.new(options)
  game_hash = game.play
  game_data << game_hash
}

end_time = Time.now
total_time = (end_time - start_time)

winner = game_data.group_by { |h| h[:winner] }
shots = game_data.group_by { |h| h[:shots] }
num_shots = shots.map { |shot| [shot[0], shot[1].length] }

num_shots = num_shots.sort do |a, b|
  a[1] <=> b[1]
end

puts "Ran #{times_to_run} games in #{total_time} seconds, average #{total_time / times_to_run} s"
puts "Computer 1 won #{winner[1].length} times, computer 2 won #{winner[2].length} times"
num_shots.each do |shot|
  puts "#{shot[1]}\tgames\t#{shot[0]}\tshots"
end

text_to_save = "New trial:\n\nOptions:\n"
text_to_save += options.to_s
text_to_save += "\n\nAI NOTES:\n#{ai_notes}\n"
text_to_save += "\nRan #{times_to_run} games in #{total_time} seconds, average #{total_time / times_to_run} s"
text_to_save += "\n\nComputer 1 won #{winner[1].length} times, computer 2 won #{winner[2].length} times\n"
num_shots.each do |shot|
  text_to_save += "\n#{shot[1]}\tgames\t#{shot[0]}\tshots"
end
text_to_save += "\n\n\n"

file_path = "./ai_data/"
file_path += Time.now.to_s[0..-6]
file_path += "AI:#{options[:a_i].to_s} #{times_to_run}runs"
file_path += "#{options[:board_width].to_s}x#{options[:board_height].to_s}"
file_path += ".txt"
File.open(file_path, 'w') { |file| file.write(text_to_save) }

=begin

GAME DATA
No computer ai. Only random guesses. No guess twice though.
Ran 10000 games in 6.025715 seconds, average 0.0006025714999999999 s
Computer 1 won 5994 times, computer 2 won 4006 times
4       games   5       shots
28      games   6       shots
77      games   7       shots
129     games   8       shots
332     games   9       shots
562     games   10      shots
859     games   11      shots
895     games   16      shots
1321    games   12      shots
1770    games   13      shots
1965    games   15      shots
2058    games   14      shots





=end
