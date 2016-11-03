#Understands gameflow, delegates to other classes to run a game

require_relative './human_player'
require_relative './cpu_player'
require_relative './board'
require_relative './board_printer'
require_relative './game_settings'
require_relative './game_prompts'

class GameEngine

  attr_writer :players

  def initialize(arguments)
    @user_interface = arguments[:user_interface]

    @players = []
    game_settings = arguments[:game_settings]
    game_settings.apply_settings(self)

    @board = Board.new
    @board_printer = BoardPrinter
  end

  def play
    until board.game_over?
      next_turn
    end
    announce_outcome
  end

  def next_turn
    ask_for_next_move(current_player)
    next_move = get_next_move
    board.add_move!(next_move, current_player.flag)
    change_turn
  end

  private 

  attr_reader :output, :board, :board_printer, :input, :players, :user_interface

  def announce_outcome
    winner_flag = board.winner_flag

    if winner_flag.nil?
      user_interface.announce_draw(printed_board)
    else
      winner_name = find_player_name(winner_flag)
      user_interface.announce_winner(winner_name, printed_board)
    end
    
  end

  def draw_message
    GAME_PROMPTS[:announce_draw]
  end

  def winner_message(winner_name)
    GAME_PROMPTS[:announce_winner] + winner_name
  end

  def ask_for_next_move(player)
    user_interface.ask_for_next_move(player.name, 
                                     board_printer.stringify_board(board))
  end

  def get_next_move
    begin
      current_player.next_move(board)
    rescue InvalidMove::IllegalInput, InvalidMove::CellAlreadyTaken => error
      output.puts(GAME_PROMPTS[:please_try_again] + error.message)
      get_next_move
    end
  end

  def find_player_name(player_flag)
    player_index = players.index { |player| player.flag == player_flag }
    players[player_index].name
  end

  def printed_board
    board_printer.stringify_board(board)
  end

  def current_player
    players.first
  end

  def change_turn
    players.rotate!
  end

  def valid_game_mode_input?(input)
    %w[1 2 3].include?(input)
  end

end
