require_relative './lib/game_engine'

game = GameEngine.new(input: STDIN, output: STDOUT)

puts 'Welcome to TicTacToe!!'

game.setup_game_mode
game.setup_play_order
game.play
