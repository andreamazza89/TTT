class GameEngine

  def initialize(arguments)
    @output = arguments[:output]
    @players = [HumanPlayer.new(name: '1'), HumanPlayer.new(name: '2')]
    @board = Board.new
  end

  def play

  #check for winner
    #ask for next move(players.first)
    #players.first.choose_next_move(board)
    #change turn
    get_next_move(players.first)

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

  attr_reader :output, :players, :board

  def get_next_move(player)
    puts "Player #{player.name}, it's your turn, have a look at the board and pick a move" + board.print_status
  end

end
