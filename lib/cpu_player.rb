require_relative './game_prompts'

class CpuPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
  end

  def next_move(board_state)
    @current_board_state = board_state
    convert_coordinates(winnable_row_index, winnable_column_index)
  end

  private

  attr_accessor :current_board_state

  def winnable_row_index
    for row_index in (0...current_board_state.length) do
      return row_index if current_board_state[row_index].count(flag) == current_board_state.length - 1
    end
  end

  def winnable_column_index
    current_board_state[winnable_row_index].index(nil)
  end

  def convert_coordinates(row_index, column_index)
    NUMBER_TO_LETTER[row_index] + (column_index + 1).to_s
  end

end
