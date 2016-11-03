require_relative '../lib/game_prompts'

def readable_moves(*moves)
  all_moves_in_one_string = moves.join("\n")
  StringIO.new(all_moves_in_one_string)
end

def new_game_engine(arguments)
  GameEngine.new(input: arguments[:input], output: mock_console)
end

def new_game_settings(arguments = {})
  input_stream = arguments[:input] || readable_moves("1", "Y")
  output_stream = arguments[:output] || DumbConsole
  GameSettings.new(input: input_stream, output: output_stream )
end

def prompt_for_input(player_name)
  player_name + GAME_PROMPTS[:ask_for_next_move]
end

def announce_winner(player_name)
  GAME_PROMPTS[:announce_winner] + player_name
end

def update_board_with_moves(board, moves)
  moves.each do |move|
    move_coordinates = move[0]
    move_flag = move[1]
    board.add_move!(move_coordinates, move_flag)
  end
end

class DumbConsole
  def self.puts(message)
  end
end
