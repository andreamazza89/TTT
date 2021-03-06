require_relative './lib/game_engine'
require_relative './lib/game_settings'
require_relative './lib/user_interface'


ui = UserInterface.new(input: STDIN, output: STDOUT)
ui.welcome

game_settings = GameSettings.new(user_interface: ui)
game_settings.select_game_mode
game_settings.select_playing_order

game = GameEngine.new(user_interface: ui, game_settings: game_settings)
game.play
