describe 'Integration - game setup' do

  let(:mock_console) { spy('Console') }

  it 'Asks the player to select player types (human or machine)' do
    mock_user_input = readable_moves(" ")
    game_engine = new_game_engine(input: mock_user_input)

    game_engine.setup_game_mode
  
    expect(mock_console).to have_received(:puts).with prompt_for_game_mode_selection
  end

  it 'Asks the player who they would like to have the first move' do
    mock_user_input = readable_moves(" ")
    game_engine = new_game_engine(input: mock_user_input)

    game_engine.setup_play_order
  
    expect(mock_console).to have_received(:puts).with prompt_for_play_order
  end

end

