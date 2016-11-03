describe 'Integration - Human move input validation' do

  let(:mock_console) { spy('Console') }

  it 'Prompts the player for another move if the one given is illegal' do
    mock_user_input = readable_moves("1", "Y", "ZZTop", "A1")
    mock_user_interface = UserInterface.new(input: mock_user_input,
                                              output: mock_console)
    game_settings = GameSettings.new(user_interface: mock_user_interface)
    game_settings.select_game_mode
    game_settings.select_playing_order
    game_engine = new_game_engine(user_interface: mock_user_interface, 
                                    game_settings: game_settings)

    game_engine.next_turn
  
    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:please_try_again] + GAME_PROMPTS[:illegal_move]
  end

  it 'Prompts the player for another move if the one given is already taken' do
    mock_user_input = readable_moves("1", "Y", "A1", "A1", "A2")
    mock_user_interface = UserInterface.new(input: mock_user_input,
                                              output: mock_console)
    game_settings = GameSettings.new(user_interface: mock_user_interface)
    game_settings.select_game_mode
    game_settings.select_playing_order
    game_engine = new_game_engine(user_interface: mock_user_interface, 
                                    game_settings: game_settings)

    game_engine.next_turn
    game_engine.next_turn
  
    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:please_try_again] + GAME_PROMPTS[:cell_already_taken]
  end
end
