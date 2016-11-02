#Understands how to identify different properties of the TicTacToe board

class BoardEvaluator

  def initialize(board)
    @board = board
  end

  def self.game_over?(board)
    new(board).game_over?
  end

  def self.winner_flag(board)
    new(board).winner_flag
  end

  def self.available_moves(board)
    new(board).available_moves
  end

  def self.empty?(board)
    new(board).empty?
  end

################################################################################
  def game_over?
    board_full? || someone_has_won? 
  end

  def winner_flag
    winning_collection.nil? ? nil : winning_collection.first.flag
  end

  def available_moves
    all_cells = board.rows.flatten
    empty_cells = all_cells.select { |cell| cell.flag.nil? }
    empty_cells.map { |cell| [cell.row, cell.column] }
  end

  def empty?
    available_moves.length == board.rows.length**2
  end
################################################################################

  private

  attr_reader :board

  def board_full?
    board.rows.flatten.none? { |cell| cell.flag == nil}
  end

  def someone_has_won?
    !!winner_flag
  end

  def winning_collection
    board.rows_cols_diags.each do |collection|
      return collection if are_all_elements_one_flag?(collection)
    end

    nil
  end

  def are_all_elements_one_flag?(collection)
    collection.none? { |cell| cell.flag.nil? } && 
    collection.map { |cell| cell.flag }.uniq.length == 1
  end

end
