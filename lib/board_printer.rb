require_relative './game_prompts'

class BoardPrinter

  def initialize(board)
    @board = board
  end

  def self.stringify_board(board)
    new(board).stringify_board
  end

  def stringify_board
    (header + board_rows.join).chomp
  end

  private 

  attr_reader :board

  def header
    "\n" + GAME_PROMPTS[:board_header]
  end

  def board_rows
    board.board_state.map.with_index do |row_content, row_index| 
      GAME_PROMPTS[:board_horizontal_spacer] + 
      stringified_row(row_index)
    end
  end

  def stringified_row(row_number)
    stringified_row = NUMBER_TO_LETTER[row_number] + 
                      stringify_row_cells(row_number) + "\n"
  end

  def stringify_row_cells(row_number)
    board.board_state[row_number].map do |cell|
      cell.nil? ? '   ' : " #{cell} "
    end.join('|')
  end

end
