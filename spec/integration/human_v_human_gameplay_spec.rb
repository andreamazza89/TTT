require 'game_engine'
require_relative '../fixtures/stringified_boards'

describe 'Integration - human v human' do

  context 'At the start' do

    it 'Asks the player for a move and shows the board' do
      mock_console = spy('Console');
      mock_user_input = File.open('spec/fixtures/one_move.ttt')
      game_engine = GameEngine.new(input: mock_user_input, output: mock_console)

      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with "Player 1, it's your turn, have a look at the board and pick a move:\n" +
              BOARDS_AS_STRINGS[:empty_board]
    end

    it 'Updates the board with first players move' do
      mock_console = spy('Console');
      mock_user_input = File.open('spec/fixtures/one_move.ttt')
      game_engine = GameEngine.new(input: mock_user_input, output: mock_console)

      game_engine.next_turn
      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with "Player 2, it's your turn, have a look at the board and pick a move:\n" +
              BOARDS_AS_STRINGS[:one_move]
    end

  end
end
