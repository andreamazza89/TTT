class GameEngine

  def initialize(arguments)
    @output = arguments[:output]
  end

  def play
    output.puts("Player 1, it’s your turn, have a look at the board and pick a move:

  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   ")
  end

  private 

  attr_reader :output

end
