class Board

  def initialize
    @board_state = create_new_board
  end

  def add_move(move, flag)
    row = extract_row(move)
    column = extract_column(move)
    board_state[row][column].flag = flag
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

  def extract_row(move)
    LETTER_TO_NUMBER[move[0]]
  end

  def extract_column(move)
    move[1].to_i - 1
  end

  LETTER_TO_NUMBER = {
    'A' => 0,
    'B' => 1,
    'C' => 2,
  }

  BOARD_SIZE = 3

end
