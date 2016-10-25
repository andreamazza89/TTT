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

    if winning_cell
      winning_row = winning_cell.row
      winning_column = winning_cell.column
      return convert_coordinates(winning_row, winning_column)
    elsif blocking_cell
      blocking_row = blocking_cell.row
      blocking_column = blocking_cell.column
      return convert_coordinates(blocking_row, blocking_column)
    elsif forking_cell
      forking_row = forking_cell.row
      forking_column = forking_cell.column
      return convert_coordinates(forking_row, forking_column)
    end
  end

  private

  attr_accessor :current_board

  #PLEASE MEMOIZE MEEEE
  def winning_cell
    winnable_combi = []
    rows_columns_diagonals = current_board.rows + current_board.columns + current_board.diagonals
    rows_columns_diagonals.each do |collection|
       winnable_combi = collection if collection.map { |cell| cell.flag }.count(flag) == 2
    end
    winnable_combi.select { |cell| cell.flag.nil? }[0]
  end

  #PLEASE MEMOIZE MEEEE
  def blocking_cell
    opponent_winnable_combi = []
    rows_columns_diagonals = current_board.rows + current_board.columns + current_board.diagonals
    rows_columns_diagonals.each do |collection|
       opponent_winnable_combi = collection if collection.map { |cell| cell.flag }.count(flag) == 0 &&
                                               collection.map { |cell| cell.flag }.count(nil) == 1
    end
    opponent_winnable_combi.select { |cell| cell.flag.nil? }[0]
  end

  #This behaviour feels very similar (inverse of the same) to what the board does 
  #to conver a 'human-language' move into array coordinates. Perhaps these are a class?
  def convert_coordinates(row_index, column_index)
    NUMBER_TO_LETTER[row_index] + (column_index + 1).to_s
  end

end
