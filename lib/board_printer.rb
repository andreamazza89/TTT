require_relative './game_prompts'

class BoardPrinter

  def initialize(board)
    @board = board
  end

  def self.stringify_board(board)
    new(board).stringify_board
  end

  def stringify_board
    output =  "\n" + GAME_PROMPTS[:board_header]
    (0..2).each do |row|
      output << GAME_PROMPTS[:board_horizontal_spacer]
      output << stringified_row(row)
    end
    output.chomp
  end

  private 

  attr_reader :board

  def stringified_row(row_number)
    stringified_row = ''
    stringified_row << NUMBER_TO_LETTER[row_number]
    stringified_row << stringify_row_cells(row_number)
    stringified_row + "\n"
  end

  def stringify_row_cells(row_number)
    board.board_state[row_number].map do |cell|
      cell.nil? ? '   ' : " #{cell} "
    end.join('|')
  end

  NUMBER_TO_LETTER = {
    0 => 'A',
    1 => 'B',
    2 => 'C',
  }

end
