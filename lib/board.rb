class Board

  def initialize
    @board_state = Array.new(3) { Array.new(3) }
  end

  def stringified_status
    "\n" + 
    header +
    horizontal_spacer +
    stringified_row(1) +
    horizontal_spacer +
    stringified_row(2) +
    horizontal_spacer +
    stringified_row(3).chomp
  end

  def add_move(move, flag)
    board_state[0][0] = 'x'
  end

  private

  attr_reader :board_state

  def header
    "  1 | 2 | 3 \n" 
  end

  def horizontal_spacer
    "  ----------\n"
  end

  def stringified_row(row_number)
    stringified_row = ''
    stringified_row << NUMBER_TO_LETTER[row_number]
    stringified_row << board_state[row_number - 1].map do |cell|
      cell.nil? ? '   ' : " #{cell} "
    end.join('|') + "\n"
  end

  NUMBER_TO_LETTER = {
    1 => 'A',
    2 => 'B',
    3 => 'C',
  }

end
