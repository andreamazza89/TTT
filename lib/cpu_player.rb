require_relative './game_prompts'

class CpuPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
  end

  def next_move(board)
    @current_board = board
    winning_row = winning_cell.row
    winning_column = winning_cell.column
    convert_coordinates(winning_row, winning_column)
  end

  private

  attr_accessor :current_board

  def winning_cell
    winning_combi = []
    rows_columns_diagonals = current_board.rows + current_board.columns + current_board.diagonals
    rows_columns_diagonals.each do |row|
       winning_combi = row if row.map { |cell| cell.flag }.count(flag) == 2
    end
    winning_combi.select { |cell| cell.flag.nil? }[0]
  end

  #This behaviour feels very similar (inverse of the same) to what the board does 
  #to conver a 'human-language' move into array coordinates. Perhaps these are a class?
  def convert_coordinates(row_index, column_index)
    NUMBER_TO_LETTER[row_index] + (column_index + 1).to_s
  end

end
