#Understands the options available to play a game of tictactoe

require_relative './game_prompts'
require_relative './human_player'
require_relative './cpu_player'

class GameSettings

  attr_accessor :players


  def initialize(arguments)
    @players = []
    @user_interface = arguments[:user_interface]
  end

  def select_game_mode
    selected_mode = user_interface.select_game_mode
    set_players_type(selected_mode)
  end

  def select_playing_order
    should_invert_order = user_interface.select_playing_order.match(YES_REGEX)
    players.rotate! if should_invert_order
  end

  def apply_settings(game_engine)
    game_engine.players = self.players
  end

  private

  attr_reader :output, :input, :user_interface

  def set_players_type(selected_mode)
    case selected_mode
      when GAME_MODES[:human_v_human]
        @players = [HumanPlayer.new({ name: 'Player 1', flag: 'x', user_interface: user_interface }), 
                    HumanPlayer.new({ name: 'Player 2', flag: 'o', user_interface: user_interface })]
      when GAME_MODES[:human_v_machine]
        @players = [HumanPlayer.new({ name: 'Player 1', flag: 'x', user_interface: user_interface }), 
                    CpuPlayer.new({ name: 'Computer', flag: 'o'})]
      when GAME_MODES[:machine_v_machine]
        @players = [CpuPlayer.new({ name: 'Computer 1', flag: 'x' }), 
                    CpuPlayer.new({ name: 'Computer 2', flag: 'o' })]
    end
  end

  GAME_MODES = {
    human_v_human: "1",
    human_v_machine: "2",
    machine_v_machine: "3"
  }

  YES_REGEX = /^Y$/i

end
