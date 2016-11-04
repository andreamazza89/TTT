#Understands how to interact with the user interface provided to get a valid move

require_relative './game_prompts'

class HumanPlayer

  attr_reader :name, :flag

  def initialize(arguments)
    @user_interface = arguments[:user_interface]
    @name = arguments[:name]
    @flag = arguments[:flag]
  end

  def next_move(board)
    graphical_coordinates = user_interface.get_next_move
    raise InvalidMove::IllegalInput unless graphical_coordinates.match(VALID_MOVE_REGEX)
    move = convert_graphical_to_board_coordinates(graphical_coordinates)
    raise InvalidMove::CellAlreadyTaken if !board.is_move_available?(move) 
    move
  end

  private

  attr_reader :user_interface

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

  VALID_MOVE_REGEX = /^[A-C][1-3]$/

end

module InvalidMove 

  class CellAlreadyTaken < StandardError
    def initialize(msg=GAME_PROMPTS[:cell_already_taken])
      super
    end
  end

  class IllegalInput < StandardError
    def initialize(msg=GAME_PROMPTS[:illegal_move])
      super
    end
  end

end
