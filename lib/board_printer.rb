require_relative './game_prompts'

class BoardPrinter

  def initialize(board)
    @board = board
  end

  def self.stringify_board(board)
    new(board).stringify_board
  end

  def stringify_board
    (header + visualise_board_rows.join).chomp
  end

  private 

  attr_reader :board

  def header
    "\n" + GAME_PROMPTS[:board_header]
  end

  def visualise_board_rows
    board.rows.map.with_index do |row_cells, row_index| 
      GAME_PROMPTS[:board_horizontal_spacer] + 
      stringify_row(row_index)
    end
  end

  def stringify_row(row_number)
    NUMBER_TO_LETTER[row_number] + stringify_row_cells(row_number) + "\n"
  end

  def stringify_row_cells(row_number)
    board.rows[row_number].map do |cell|
      cell.flag.nil? ? '   ' : " #{cell.flag} "
    end.join(GAME_PROMPTS[:vertical_cell_separator])
  end

end
