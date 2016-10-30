#Understands how to select the optimal next move using the minimax algorithm

require_relative './board_evaluator'

class CpuPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @name = arguments[:name] 
    @flag = arguments[:flag]
    @opponents_flag = nil
    @board_evaluator = BoardEvaluator
  end

  def next_move(board)
    available_moves = board.available_moves
    return available_moves.first if board.empty?
    available_moves.max_by do |move|
      rate_move_outcome(board, move, true, INITIAL_BOARD_DEPTH)
    end
  end

  private

  attr_reader :board_evaluator
  attr_accessor :opponents_flag

  def rate_move_outcome(board, move, is_maximising_player, depth)
    player_flag = is_maximising_player ? self.flag : opponents_flag(board)
    next_board = board.add_move(move, player_flag)
    return final_board_value(next_board, depth) if game_over?(next_board)
    rate_intermediate_board_value(next_board, !is_maximising_player, depth)
  end

  def final_board_value(board, depth)
    if (winner_flag = winner_flag(board))
      (winner_flag == self.flag) ? 10 - depth : depth - 10
    else
      0
    end
  end

  def rate_intermediate_board_value(board, is_maximising_player, depth)
    all_moves_ratings = rate_intermediate_moves(board, is_maximising_player, depth)
    is_maximising_player ? all_moves_ratings.max : all_moves_ratings.min
  end

  def rate_intermediate_moves(board, is_maximising_player, depth)
    board.available_moves.map do |move| 
      rate_move_outcome(board, move, is_maximising_player, depth + 1)
    end
  end

  def opponents_flag(board)
    opponents_flag ||= board.rows.each do |row|
      row.each do |cell|
        other_flag = cell.flag
        return other_flag if (other_flag != self.flag) && (other_flag != nil)
      end
    end
  end

  def winner_flag(board)
    board_evaluator.winner_flag(board)
  end

  def game_over?(board)
    board_evaluator.game_over?(board)
  end

  INITIAL_BOARD_DEPTH = 0

end
