require_relative './game_prompts'

class CpuPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @name = arguments[:name] 
    @flag = arguments[:flag]
    @board_evaluator = BoardEvaluator
  end

  def next_move(board)
    available_moves(board).max_by do |move| 
      evaluate_move_outcome(board, move, true)
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
    convert_coordinates(cell.row, cell.column) 
  end

  def evaluate_move_outcome(board, move, is_maximising_player)
    temporary_board = Marshal.load(Marshal.dump(board)) 
    player_flag = is_maximising_player ? 'x' : 'o'
    temporary_board.add_move(move, player_flag) #################REFACTOR TO REMOVE ASSUMPTION OF OTHER PLAYERS FLAG
#p non_final_board_value(temporary_board, is_maximising_player)
    return final_board_value(temporary_board) if game_over?(temporary_board)
    non_final_board_value(temporary_board, is_maximising_player)
  end

  def final_board_value(board)
    if winner_flag(board)
      (winner_flag(board) == self.flag) ? 1 : -1
    else
      0
    end
  end

#MEMOIZE MEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  def winner_flag(board)
    board_evaluator.winner_flag(board)
  end

  def game_over?(board)
    board_evaluator.game_over?(board)
  end

  def non_final_board_value(board, is_maximising_player)
    if is_maximising_player
      return available_moves(board).max_by { |move| evaluate_move_outcome(board, move, !is_maximising_player) }
    else
      return available_moves(board).min_by { |move| evaluate_move_outcome(board, move, !is_maximising_player) }
    end
  end

  #This behaviour feels very similar (inverse of the same) to what the board does 
  #to conver a 'human-language' move into array coordinates. Perhaps these are a class?
  def convert_coordinates(row_index, column_index)
    NUMBER_TO_LETTER[row_index] + (column_index + 1).to_s
  end

end
