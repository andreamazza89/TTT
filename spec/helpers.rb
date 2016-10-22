def readable_moves(*moves)
  all_moves_in_one_string = moves.join("\n")
  StringIO.new(all_moves_in_one_string)
end

def new_game_engine(arguments)
  GameEngine.new(input: arguments[:input], output: mock_console)
end

def prompt_for_input(player_name)
  "#{player_name}, it's your turn, have a look at the board and pick a move:\n"
end

def announce_winner(player_name)
  "Game over: #{player_name} wins!"
end
