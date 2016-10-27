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
    board_columns = []
    board_state.length.times do |column_index|
      column = []
      rows.each { |row| column << row[column_index] }
      board_columns << column
    end
    board_columns 
  end

  def diagonals
    [downward_diagonal, upward_diagonal]
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

  BOARD_SIZE = 3

end
