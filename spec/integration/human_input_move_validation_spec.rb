describe 'Integration - Human move input validation' do

  let(:mock_console) { spy('Console') }

    it 'Prompts the player for another move if the one given is illegal' do
      mock_user_input = readable_moves("ZZTop", "A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
    
      expect(mock_console).to have_received(:puts)
        .with please_try_again(GAME_PROMPTS[:illegal_move])
    end

    it 'Prompts the player for another move if the one given is already taken' do
      mock_user_input = readable_moves("A1", "A1", "A2")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
      game_engine.next_turn
    
      expect(mock_console).to have_received(:puts)
        .with please_try_again(GAME_PROMPTS[:cell_already_taken])
    end

end
