require_relative 'human_player'
require_relative 'board'
require_relative 'board_printer'
require_relative 'board_evaluator'
require_relative './game_prompts'

class GameEngine

  def initialize(arguments)
    input = arguments[:input]
    player_one = HumanPlayer.new(name: 'Player 1', input: input, flag: 'x')
    player_two = HumanPlayer.new(name: 'Player 2', input: input, flag: 'o')
    @players = [player_one, player_two]
    @board = Board.new
    @board_printer = BoardPrinter
    @board_evaluator = BoardEvaluator
    @output = arguments[:output]
  end

  def setup_game_mode
    output.puts(GAME_PROMPTS[:game_mode_selection]) 
  end

  def play
    until game_over?
      next_turn
    end
    announce_outcome
  end

  def next_turn
    ask_for_next_move(current_player)
    board.add_move!(current_player.next_move, current_player.flag)
    change_turn
  end

  private 

  attr_reader :output, :players, :board, :board_printer, :board_evaluator

  def game_over?
    board_evaluator.game_over?(board)
  end

  def announce_outcome
    winner_flag = board_evaluator.winner_flag(board)
    winner_index = players.index { |player| player.flag == winner_flag }
    winner = players[winner_index] unless winner_index.nil?
    output.puts((winner.nil? ? draw_message : winner_message(winner)) + board_printer.stringify_board(board))
  end

  def draw_message
    GAME_PROMPTS[:announce_draw]
  end

  def winner_message(winner)
    "Game over: #{winner.name} wins!\n"
  end

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
