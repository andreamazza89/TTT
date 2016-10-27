require_relative 'human_player'
require_relative 'cpu_player'
require_relative 'board'
require_relative 'board_printer'
require_relative 'board_evaluator'
require_relative './game_prompts'

class GameEngine

  def initialize(arguments)
    @input = arguments[:input]
    @output = arguments[:output]

    player_one = default_human_player('Player 1', 'x', input)
    player_two = default_human_player('Player 2', 'o', input)
    @players = [player_one, player_two]

    @board = Board.new
    @board_printer = BoardPrinter
    @board_evaluator = BoardEvaluator
  end

  def setup_game_mode
    output.puts(GAME_PROMPTS[:game_mode_selection]) 
    selected_mode = input.gets.chomp
    case selected_mode
      when GAME_MODES[:human_v_human]
        @players = [default_human_player('Player 1', 'x', input), default_human_player('Player 2', 'o', input)]
      when GAME_MODES[:human_v_machine]
        @players = [default_human_player('Player 1', 'x', input), default_machine_player('Player 2', 'o')]
      when GAME_MODES[:machine_v_machine]
        @players = [default_machine_player('Player 1', 'x'), default_machine_player('Player 2', 'o')]
    end
  end

  def setup_play_order
    output.puts(GAME_PROMPTS[:play_order_selection]) 
    should_invert_playing_order = input.gets.chomp == "Y"
    change_turn if should_invert_playing_order
  end

  def play
    until game_over?
      next_turn
    end
    announce_outcome
  end

  def next_turn
    ask_for_next_move(current_player)
    board.add_move!(current_player.next_move(board), current_player.flag)
    change_turn
  end

  private 

  attr_reader :output, :board, :board_printer, :board_evaluator, :input, :players

  def default_human_player(name, flag, input)
    HumanPlayer.new(name: name, flag: flag, input: input)
  end

  def default_machine_player(name, flag)
    CpuPlayer.new(name: name, flag: flag)
  end

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

  GAME_MODES = {
    human_v_human: "1",
    human_v_machine: "2",
    machine_v_machine: "3"
  }

end
