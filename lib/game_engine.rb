require 'human_player'
require 'board'
require 'board_printer'
require_relative './game_prompts'

class GameEngine

  def initialize(arguments)
    input = arguments[:input]
    player_one = HumanPlayer.new(name: 'Player 1', input: input, flag: 'x')
    player_two = HumanPlayer.new(name: 'Player 2', input: input, flag: 'o')
    @players = [player_one, player_two]
    @board = Board.new
    @board_printer = BoardPrinter
    @output = arguments[:output]
  end

  def next_turn
    ask_for_next_move(current_player)
    board.add_move(current_player.next_move, current_player.flag)
    change_turn
  end

  private 

  attr_reader :output, :players, :board, :board_printer

  def ask_for_next_move(player)
    output.puts player.name + 
                GAME_PROMPTS[:ask_for_next_move] + "\n" +
                board_printer.stringify_board(board)
  end

  def current_player
    players.first
  end

  def change_turn
    players.rotate!
  end

end
