class Board

  def initialize
    @board_state = Array.new(3) { Array.new(3) }
  end

  def stringified_status
    output =  "\n" + header
    (0..2).each do |row|
      output << horizontal_spacer
      output << stringified_row(row)
    end
    output.chomp
  end

  def add_move(move, flag)
    row = extract_row(move)
    column = extract_column(move)
    board_state[row][column] = flag
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
    stringified_row << stringify_row_cells(row_number)
    stringified_row + "\n"
  end

  def stringify_row_cells(row_number)
    board_state[row_number].map do |cell|
      cell.nil? ? '   ' : " #{cell} "
    end.join('|')
  end

  def extract_row(move)
    LETTER_TO_NUMBER[move[0]]
  end

  def extract_column(move)
    move[1].to_i - 1
  end

  NUMBER_TO_LETTER = {
    0 => 'A',
    1 => 'B',
    2 => 'C',
  }

  LETTER_TO_NUMBER = {
    'A' => 0,
    'B' => 1,
    'C' => 2,
  }

end
