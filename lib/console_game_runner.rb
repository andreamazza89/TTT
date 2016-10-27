require_relative './game_engine'

game = GameEngine.new(input: STDIN, output: STDOUT)

game.setup_game_mode
game.setup_play_order
game.play
