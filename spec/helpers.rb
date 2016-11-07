require_relative '../lib/game_prompts'

def readable_moves(*moves)
  all_moves_in_one_string = moves.join("\n")
  StringIO.new(all_moves_in_one_string)
end

def new_game_engine(arguments)
  GameEngine.new(user_interface: arguments[:user_interface], 
                 game_settings: arguments[:game_settings])
end

def create_game_engine(input, output)
  user_interface = UserInterface.new(input: input,
                                     output: output)
  game_settings = GameSettings.new(user_interface: user_interface)
  game_settings.select_game_mode
  game_settings.select_playing_order
  game_engine = new_game_engine(user_interface: user_interface, 
                                game_settings: game_settings)
  game_engine
end

def new_game_settings(arguments = {})
  user_interface = arguments[:user_interface]
  GameSettings.new(user_interface: user_interface)
end

def new_user_interface(arguments)
  input_stream = arguments[:input] || DumbIOStream
  output_stream = arguments[:output] || DumbIOStream
  board_printer = arguments[:board_printer]
  UserInterface.new(input: input_stream, output: output_stream, 
                    board_printer: board_printer)
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

class DumbIOStream
  def self.puts(message)
  end
  def self.gets
    'whatever the real stream returns'
  end
end
