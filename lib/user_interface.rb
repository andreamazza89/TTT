require_relative './game_prompts'
require_relative './board_printer'

class UserInterface

  def initialize(arguments)
    @output = arguments[:output]
    @input = arguments[:input]
    @board_printer = arguments[:board_printer] || BoardPrinter
  end

  def welcome
    send_to_output(GAME_PROMPTS[:welcome])
  end

  def announce_draw(board)
    send_to_output(GAME_PROMPTS[:announce_draw] + printed_board(board))
  end

  def announce_winner(player, board)
    winners_name = player.name
    send_to_output(GAME_PROMPTS[:announce_winner] + 
                   winners_name + 
                   printed_board(board))
  end

  def ask_for_next_move(player, board)
    send_to_output(player.name + GAME_PROMPTS[:ask_for_next_move] + printed_board(board))
  end

  def get_next_move
    read_from_input
  end

  def invalid_input(reason)
    send_to_output(GAME_PROMPTS[:please_try_again] + reason)
  end 

  def select_game_mode
    send_to_output(GAME_PROMPTS[:game_mode_selection]) 
    read_from_input
  end

  def select_playing_order
    send_to_output(GAME_PROMPTS[:play_order_selection]) 
    read_from_input
  end

  def invalid_game_mode_selection
    send_to_output(GAME_PROMPTS[:invalid_game_mode_selection]) 
  end

  private
  
  attr_reader :output, :input, :board_printer

  def send_to_output(message)
    output.puts(message)
  end

  def read_from_input
    input.gets.chomp 
  end

  def printed_board(board)
    board_printer.stringify_board(board)
  end
end
