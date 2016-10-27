require_relative './game_prompts'

class HumanPlayer

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
  end

  #the board is passed to this method as the CPU player needs it to evaluate next
  #move and to keep the same interface
  def next_move(board_not_required)
    graphical_coordinates = input.gets.chomp
    convert_graphical_to_board_coordinates(graphical_coordinates)
  end

  attr_reader :name, :flag

  private

  attr_reader :input

  def convert_graphical_to_board_coordinates(graphical_coordinates)
    row = extract_row(graphical_coordinates)
    column = extract_column(graphical_coordinates)
    [row, column] 
  end

  def extract_row(move)
    LETTER_TO_NUMBER[move[0]]
  end

  def extract_column(move)
    move[1].to_i - 1
  end

end
