require_relative './lib/game_engine'
require_relative './lib/game_settings'

puts 'Welcome to TicTacToe!!'

game_settings = GameSettings.new(input: STDIN, output: STDOUT)
game_settings.select_game_mode
game_settings.select_playing_order
game = GameEngine.new(input: STDIN, output: STDOUT, game_settings: game_settings)

game.play
