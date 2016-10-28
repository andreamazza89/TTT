describe 'Integration - game setup' do

  let(:mock_console) { spy('Console') }

  context 'When the input is valid' do
    it 'Asks the player to select a game mode' do
      mock_user_input = readable_moves("1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_game_mode
    
      expect(mock_console).to have_received(:puts)
        .with GAME_PROMPTS[:game_mode_selection]
    end

    it 'Asks the player who they would like to take the first move' do
      mock_user_input = readable_moves(" ")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_play_order
    
      expect(mock_console).to have_received(:puts)
        .with GAME_PROMPTS[:play_order_selection]
    end

    it 'Swaps the playing order if user inputs y to play order prompt' do
      mock_user_input = readable_moves("y", "A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_play_order
      game_engine.next_turn
    
      expect(mock_console)
        .to have_received(:puts)
        .with prompt_for_input('Player 2') + VISUAL_BOARD[:no_moves] 
    end

    it 'Swaps the playing order if user inputs Y to play order prompt' do
      mock_user_input = readable_moves("Y", "A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_play_order
      game_engine.next_turn
    
      expect(mock_console)
        .to have_received(:puts)
        .with prompt_for_input('Player 2') + VISUAL_BOARD[:no_moves] 
    end

    it 'Assumes anything but [y Y] means no when asking for play order' do
      mock_user_input = readable_moves("bad input", "A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_play_order
      game_engine.next_turn
    
      expect(mock_console)
        .to have_received(:puts)
        .with prompt_for_input('Player 1') + VISUAL_BOARD[:no_moves] 
    end
  end


  context 'When the input is invalid' do
    it 'Asks again for game mode' do
      mock_user_input = readable_moves("bad input", "1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.setup_game_mode
    
      expect(mock_console).to have_received(:puts)
        .with GAME_PROMPTS[:invalid_game_mode_selection]
    end
  end
end

