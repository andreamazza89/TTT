require_relative '../lib/game_prompts'
#####IMPORT AND USE THE STANDARD PROMPTS

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
  "Game over: #{player_name} wins!\n"
end

def announce_draw
  GAME_PROMPTS[:announce_draw] 
end

def update_board_with_moves(board, moves)
  moves.each do |move|
    move_coordinates = move[0]
    move_flag = move[1]
    board.add_move!(move_coordinates, move_flag)
  end
end

def please_try_again(msg)
  GAME_PROMPTS[:please_try_again] + msg
end
