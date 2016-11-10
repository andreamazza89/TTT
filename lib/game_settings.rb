#Understands the options available to play a game of tictactoe

require_relative './game_prompts'
require_relative './human_player'
require_relative './cpu_player'

class GameSettings

  def initialize(arguments)
    @user_interface = arguments[:user_interface]
    @game_engine = arguments[:game_engine]
  end

  def select_game_mode
    selected_mode = user_interface.select_game_mode
    until valid_game_mode_input?(selected_mode)
      user_interface.invalid_game_mode_selection
      selected_mode = user_interface.select_game_mode
    end
    game_engine.players = set_players_type(selected_mode)
  end

  def select_playing_order
    should_invert_order = user_interface.select_playing_order.match(YES_REGEX)
    game_engine.change_turn if should_invert_order
  end

  def apply_settings(game_engine)
    game_engine.players = self.players
  end

  private

  attr_reader :output, :input, :user_interface, :game_engine

  def set_players_type(selected_mode)
    case selected_mode
      when GAME_MODES[:human_v_human]
        @players = [default_human_player('Player 1', 'x'), 
                    default_human_player('Player 2', 'o')]
      when GAME_MODES[:human_v_machine]
        @players = [default_human_player('Player 1', 'x'), 
                    default_cpu_player('Computer', 'o')]
      when GAME_MODES[:machine_v_machine]
        @players = [default_cpu_player('Computer 1', 'x'), 
                    default_cpu_player('Computer 2', 'o')]
    end
  end

  def default_human_player(name, flag)
    HumanPlayer.new({ name: name, flag: flag, user_interface: user_interface })
  end

  def default_cpu_player(name, flag)
    CpuPlayer.new({ name: name, flag: flag })
  end

  def valid_game_mode_input?(input)
    %w[1 2 3].include?(input)
  end

  GAME_MODES = {
    human_v_human: "1",
    human_v_machine: "2",
    machine_v_machine: "3"
  }

  YES_REGEX = /^Y$/i

end
