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
    current_player = players.first
    ask_for_next_move(players.first)
    board.add_move(current_player.next_move, current_player.flag)
    change_turn
  end

  private 

  attr_reader :output, :players, :board

  def ask_for_next_move(player)
    output.puts "Player #{player.name}, it's your turn, have a look at the board and pick a move:\n" + board.stringified_status
  end

  def change_turn
    players.rotate!
  end

end
