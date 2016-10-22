class BoardEvaluator

  def initialize(board_rows)
    @board_rows = board_rows
    @are_all_elements_equal = lambda { |collection| collection.uniq.length == 1 }
  end

  def self.game_over?(board_rows)
    new(board_rows).game_over?
  end

  def game_over?
    board_full? || someone_has_won? 
  end

  private

  attr_reader :board_rows, :are_all_elements_equal

  def board_full?
    board_rows.flatten.none? { |cell| cell == nil}
  end

  def someone_has_won?
    winning_column_exists? || winning_row_exists? || winning_diagonal_exists?
  end

  def winning_column_exists?
    board_columns.any?(&are_all_elements_equal)
  end

  def winning_row_exists?
    board_rows.any?(&are_all_elements_equal)
  end

  def winning_diagonal_exists?
    board_diagonals.any?(&are_all_elements_equal)
  end

  def board_columns #MEMOIZE ME?
    board_columns = []
    board_rows.length.times do |column_index|
      column = []
      board_rows.each { |row| column << row[column_index] }
      board_columns << column
    end
    board_columns 
  end

  def board_diagonals #MEMOIZE ME?
    [downward_diagonal, upward_diagonal]
  end

  def downward_diagonal
    board_rows.map.with_index { |row, index| row[index] }.flatten
  end

  def upward_diagonal
    board_rows.reverse.map.with_index { |row, index| row[index] }.flatten
  end

end
