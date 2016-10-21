require 'game_engine'

describe 'Integration - human v human' do

  context 'At the start' do

    it 'Asks the player for a move and shows the board' do
      mock_console = spy('Console');
      game_engine = GameEngine.new(output: mock_console)

      game_engine.play
      
      expect(mock_console).to have_received(:puts)
        .with "Player 1, it's your turn, have a look at the board and pick a move:

  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   "
    end

    xit 'Updates the board with first players move' do
      mock_console = spy('Console');
      mock_user = File.open('spec/fixtures/one_move.ttt')
      game_engine = GameEngine.new(input: mock_user, output: mock_console)

      game_engine.play
      
      expect(mock_console).to have_received(:puts)
        .with "Player 2, it's your turn, have a look at the board and pick a move:

  1 | 2 | 3 
  ----------
A x |   |   
  ----------
B   |   |   
  ----------
C   |   |   "
    end

  end
end
