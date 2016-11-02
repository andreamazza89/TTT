#Understands the properties of a TicTacToe board

require_relative './cell'

class Board

  def initialize
    @board_state = create_new_board
  end

  def add_move!(move, flag)
    row = move[0]
    column = move[1]
    board_state[row][column].flag = flag
  end

  def add_move(move, flag)
    new_board = Marshal.load(Marshal.dump(self))
    new_board.add_move!(move, flag)
    new_board
  end

  def rows
    board_state
  end

  def columns
   rows[0].zip(rows[1], rows[2])
  end

  def diagonals
    [downward_diagonal, upward_diagonal]
  end

  def rows_cols_diags
    rows + columns + diagonals 
  end

  def available_moves
    all_cells = rows.flatten
    empty_cells = all_cells.select { |cell| cell.flag.nil? }
    empty_cells.map { |cell| [cell.row, cell.column] }
  end

  def empty?
    available_moves.length == BOARD_SIZE**2
  end

  def winner_flag
    winning_collection.nil? ? nil : winning_collection.first.flag
  end

  def game_over?
    board_full? || someone_has_won? 
  end

  private

  attr_reader :board_state

  def downward_diagonal
    rows.map.with_index { |row, index| row[index] }.flatten
  end

  def upward_diagonal
    rows.reverse.map.with_index { |row, index| row[index] }.flatten
  end

  def create_new_board
    board = []
    for row_index in 0...BOARD_SIZE do
       row = []
      for column in 0...BOARD_SIZE do
        row << Cell.new(row: row_index, column: column)
      end
      board << row
    end
    board
  end

  def winning_collection
    rows_cols_diags.each do |collection|
      return collection if are_all_elements_one_flag?(collection)
    end

    nil
  end

  def are_all_elements_one_flag?(collection)
    collection.none? { |cell| cell.flag.nil? } && 
    collection.map { |cell| cell.flag }.uniq.length == 1
  end

  def board_full?
    rows.flatten.none? { |cell| cell.flag == nil}
  end

  def someone_has_won?
    !!winner_flag
  end

  BOARD_SIZE = 3

end
