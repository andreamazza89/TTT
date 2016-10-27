require_relative './game_prompts'
require_relative './board_evaluator'

class CpuPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @name = arguments[:name] 
    @flag = arguments[:flag]
    @board_evaluator = BoardEvaluator
  end

  def next_move(board)
    available_moves(board).max_by do |move| evaluate_move_outcome(board, move, true, 0)
    end
  end

  private

  attr_reader :board_evaluator

  def available_moves(board)
    all_cells = board.rows.flatten
    empty_cells = all_cells.select { |cell| cell.flag.nil? }
    empty_cells.map { |cell| convert_cell_to_move(cell) }
  end

  def convert_cell_to_move(cell)
    convert_coordinates([cell.row, cell.column]) 
  end

  def evaluate_move_outcome(board, move, is_maximising_player, depth)
    player_flag = is_maximising_player ? 'x' : 'o' #################REFACTOR TO REMOVE ASSUMPTION
    next_board = board.add_move(move, player_flag)
    return final_board_value(next_board, depth) if game_over?(next_board)
    non_final_board_value(next_board, !is_maximising_player, depth)
  end

  def final_board_value(board, depth)
    if (winner_flag = winner_flag(board))
      (winner_flag == self.flag) ? 10 - depth : depth - 10
    else
      0
    end
  end

  def non_final_board_value(board, is_maximising_player, depth)
    if is_maximising_player
      available_moves(board).map do |move| 
        evaluate_move_outcome(board, move, is_maximising_player, depth + 1)
      end.max
    else
      available_moves(board).map do |move| 
        evaluate_move_outcome(board, move, is_maximising_player, depth + 1)
      end.min
    end
  end

  def winner_flag(board)
    board_evaluator.winner_flag(board)
  end

  def game_over?(board)
    board_evaluator.game_over?(board)
  end

  #This behaviour feels very similar (inverse of the same) to what the board does 
  #to conver a 'human-language' move into array coordinates. Perhaps these are a class?
  def convert_coordinates(coordinates)
    NUMBER_TO_LETTER[coordinates[0]] + (coordinates[1] + 1).to_s
  end

end
