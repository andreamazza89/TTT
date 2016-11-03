#Understands the options available to play a game of tictactoe

require_relative './game_prompts'

class GameSettings

  attr_accessor :players


  def initialize(arguments)
    @players = []
    @output = arguments[:output]
    @input = arguments[:input]
  end

  def select_game_mode
    output.puts(GAME_PROMPTS[:game_mode_selection])
    selected_mode = input.gets.chomp
    set_players_type(selected_mode)
  end

  def select_playing_order
    output.puts(GAME_PROMPTS[:play_order_selection])
    should_invert_order = input.gets.chomp.match(YES_REGEX)
    players.rotate! if should_invert_order
  end

  def apply_settings(game_engine)
    game_engine.players = self.players
  end

  private

  attr_reader :output, :input

  def set_players_type(selected_mode)
    case selected_mode
      when GAME_MODES[:human_v_human]
        @players = [HumanPlayer.new({name: 'Player 1', flag: 'x', input: input}), 
                    HumanPlayer.new({name: 'Player 2', flag: 'o', input: input})]
      when GAME_MODES[:human_v_machine]
        @players = [HumanPlayer.new({name: 'Player 1', flag: 'x', input: input}), 
                    CpuPlayer.new({name: 'Computer', flag: 'o', input: input})]
      when GAME_MODES[:machine_v_machine]
        @players = [CpuPlayer.new({name: 'Computer 1', flag: 'x', input: input}), 
                    CpuPlayer.new({name: 'Computer 2', flag: 'o', input: input})]
    end
  end

  GAME_MODES = {
    human_v_human: "1",
    human_v_machine: "2",
    machine_v_machine: "3"
  }

  YES_REGEX = /^Y$/i

end
