To launch in terminal:  
```
$ ruby Battleship.rb
```
from the project directory.  

To launch in browser:  

```
$ ruby serve_battleship.rb
```

Then go to your browser and navigate to http://localhost:9292/?new_game.  

To give input, enter http://localhost:9292/?game=number&input=A1
where `number` is the game_id that the server assigns you and `a1` is whatever coordinate you'd like to enter.

As of now, a game can be played through the server, but there are bugs when it comes to placing ships. It's recommended you start a game in the terminal, save it, and then use the name of the save as the id to play it.
