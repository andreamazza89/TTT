describe 'Integration - human v human' do

  let(:mock_console) { spy('Console') }

  context 'At the start of the game, with no custom configuration' do

    it 'Asks the player for a move and shows the board' do
      mock_user_input = readable_moves("A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with prompt_for_input('Player 1') + VISUAL_BOARD[:no_moves]
    end

    it 'Updates the board with first move' do
      mock_user_input = readable_moves("A1", "B2")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with prompt_for_input('Player 2') + VISUAL_BOARD[:one_move]
    end

  end

  context 'Full game' do

    it 'Announces a winner when there is one (Player 1 wins)' do
      mock_user_input = readable_moves("A1", "A2", "B2", "A3", "C3")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.play
      
      expect(mock_console).to have_received(:puts)
        .with announce_winner('Player 1')
    end

  end
end
