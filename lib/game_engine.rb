#Understands gameflow, delegates to other classes to run a game

require_relative './board'
require_relative './game_settings'

class GameEngine

  attr_writer :players

  def initialize(arguments)
    @user_interface = arguments[:user_interface]

    @players = []

    @board = Board.new
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

  def change_turn
    players.rotate!
  end

  private 

  attr_reader :output, :board, :input, :players, :user_interface

  def announce_outcome
    winner_flag = board.winner_flag

    if winner_flag.nil?
      user_interface.announce_draw(board)
    else
      winner = find_player(winner_flag)
      user_interface.announce_winner(winner, board)
    end
    
  end

  def ask_for_next_move(player)
    user_interface.ask_for_next_move(player, board)
  end

  def get_next_move
    begin
      current_player.next_move(board)
    rescue InvalidMove::IllegalInput, InvalidMove::CellAlreadyTaken => error
      user_interface.invalid_input(error.message)
      get_next_move
    end
  end

  def find_player(player_flag)
    player_index = players.index { |player| player.flag == player_flag }
    players[player_index]
  end

  def current_player
    players.first
  end

  def valid_game_mode_input?(input)
    %w[1 2 3].include?(input)
  end

end
