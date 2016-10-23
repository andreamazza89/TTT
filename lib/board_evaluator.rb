class BoardEvaluator

  def initialize(board_rows)
    @board_rows = board_rows
    @are_all_elements_one_flag = lambda { |collection| collection.none? { |element| element.nil? } && collection.uniq.length == 1 }
  end

  def self.game_over?(board_rows)
    new(board_rows).game_over?
  end

  def self.winner_flag(board_rows)
    new(board_rows).winner_flag
  end

  def game_over?
    board_full? || someone_has_won? 
  end

  def winner_flag
    winning_collection.first
  end

  private

  attr_reader :board_rows, :are_all_elements_one_flag

  def board_full?
    board_rows.flatten.none? { |cell| cell == nil}
  end

  def someone_has_won?
    winning_row_exists? || winning_column_exists? || winning_diagonal_exists?
  end

  def winning_row_exists?
    board_rows.any?(&are_all_elements_one_flag)
  end

  def winning_column_exists?
    board_columns.any?(&are_all_elements_one_flag)
  end

  def winning_diagonal_exists?
    board_diagonals.any?(&are_all_elements_one_flag)
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

  def winning_collection
    if winning_column_exists?
      board_columns.each { |column| return column if are_all_elements_one_flag.call(column) }
    elsif winning_row_exists?
      board_rows.each { |row| return row if are_all_elements_one_flag.call(row) }
    else
      board_diagonals.each { |diagonal| return diagonal if are_all_elements_one_flag.call(diagonal) }
    end
  end

end
