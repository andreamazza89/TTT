class GameEngine

  def initialize(arguments)
    input = arguments[:input]
    player_one = HumanPlayer.new(name: '1', input: input)
    player_two = HumanPlayer.new(name: '2', input: input)
    @players = [player_one, player_two]
    @board = Board.new
    @output = arguments[:output]
  end

  def next_turn

##########################################
  #check for winner
    #ask for next move(players.first)
    #players.first.choose_next_move(board)
    #change turn
##########################################
    move = get_next_move(players.first)
    board.add_move(move, players.first.flag)

  end

  private 

  attr_reader :output, :players, :board

  def get_next_move(player)
    output.puts "Player #{player.name}, it's your turn, have a look at the board and pick a move:\n" + board.stringified_status
    player.next_move
  end

end
