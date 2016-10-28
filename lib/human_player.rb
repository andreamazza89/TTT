require_relative './game_prompts'

class HumanPlayer

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
  end

  def next_move(board)
    graphical_coordinates = input.gets.chomp
    raise InvalidMove::IllegalInput unless graphical_coordinates.match(VALID_MOVE_REGEX)
    move = convert_graphical_to_board_coordinates(graphical_coordinates)
    raise InvalidMove::CellAlreadyTaken if board.available_moves.none? { |existing_move| existing_move == move }
    move
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

  VALID_MOVE_REGEX = /[A-C][1-3]/

end

module InvalidMove 

  class CellAlreadyTaken < StandardError
    def initialize(msg="Cannot make move: cell already taken")
      super
    end
  end

  class IllegalInput < StandardError
    def initialize(msg="Cannot make move: invalid input")
      super
    end
  end

end
