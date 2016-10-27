class BoardEvaluator

  def initialize(board)
    @board = board
    @are_all_elements_one_flag = lambda do |collection| 
      collection.none? { |cell| cell.flag.nil? } && 
      collection.map { |cell| cell.flag }.uniq.length == 1
    end
  end

  def self.game_over?(board)
    new(board).game_over?
  end

  def self.winner_flag(board)
    new(board).winner_flag
  end

  def game_over?
    board_full? || someone_has_won? 
  end

  def winner_flag
    winning_collection.nil? ? nil : winning_collection.first.flag
  end

  private

  attr_reader :board, :are_all_elements_one_flag

  def board_full?
    board.rows.flatten.none? { |cell| cell.flag == nil}
  end

  def someone_has_won?
    !!winner_flag
  end

  def winning_collection
    [board.rows, board.columns, board.diagonals].each do |rows_columns_diagonals|
      rows_columns_diagonals.each do |collection|
        return collection if are_all_elements_one_flag.call(collection)
      end
    end

    nil
  end

end
