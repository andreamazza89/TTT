class Board

  attr_reader :board_state

  def initialize
    @board_state = Array.new(3) { Array.new(3) }
  end

  def add_move(move, flag)
    row = extract_row(move)
    column = extract_column(move)
    board_state[row][column] = flag
  end

  private

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

end
