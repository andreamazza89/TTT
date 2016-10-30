#Understands how to interact with the inputStream provided to get a valid move

require_relative './game_prompts'
require_relative './board_evaluator'

class HumanPlayer

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
    @board_evaluator = BoardEvaluator
  end

  def next_move(board)
    graphical_coordinates = input.gets.chomp
    raise InvalidMove::IllegalInput unless graphical_coordinates.match(VALID_MOVE_REGEX)
    move = convert_graphical_to_board_coordinates(graphical_coordinates)
    if board_evaluator.available_moves(board).none? { |available_move| available_move == move }
      raise InvalidMove::CellAlreadyTaken 
    end
    move
  end

  attr_reader :name, :flag, :board_evaluator

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
