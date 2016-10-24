class BoardEvaluator

  def initialize(board_rows)
    @board_rows = board_rows
    @are_all_elements_one_flag = lambda do |collection| 
      collection.none? { |element| element.nil? } && 
      collection.uniq.length == 1
    end
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
    !!winner_flag
  end

  def board_columns
    board_columns = []
    board_rows.length.times do |column_index|
      column = []
      board_rows.each { |row| column << row[column_index] }
      board_columns << column
    end
    board_columns 
  end

  def board_diagonals
    [downward_diagonal, upward_diagonal]
  end

  def downward_diagonal
    board_rows.map.with_index { |row, index| row[index] }.flatten
  end

  def upward_diagonal
    board_rows.reverse.map.with_index { |row, index| row[index] }.flatten
  end

  def winning_collection
    [board_rows, board_columns, board_diagonals].each do |multi_collection|
      multi_collection.each do |collection|
        return collection if are_all_elements_one_flag.call(collection)
      end
    end

    [nil]
  end

end
