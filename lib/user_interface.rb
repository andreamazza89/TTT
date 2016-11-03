class UserInterface

  def initialize(arguments)
    @output = arguments[:output]
    @input = arguments[:input]
  end

  def welcome
    send_to_output(GAME_PROMPTS[:welcome])
  end

  def announce_draw(final_board)
    send_to_output(GAME_PROMPTS[:announce_draw] + final_board)
  end

  def announce_winner(name, final_board)
    send_to_output(GAME_PROMPTS[:announce_winner] + name + final_board)
  end

  def get_next_move(player, board)
    send_to_output(player + GAME_PROMPTS[:ask_for_next_move] + board)
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

  private
  
  attr_reader :output, :input

  def send_to_output(message)
    output.puts(message)
  end

  def read_from_input
    input.gets.chomp 
  end
end
