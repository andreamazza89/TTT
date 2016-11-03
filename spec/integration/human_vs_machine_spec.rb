describe 'Integration - human v machine' do

  let(:mock_console) { spy('Console') }

  it 'Machine beats human if given a chance' do
    mock_user_input = readable_moves("2", "Y", "C2", "C1")
    mock_user_interface = UserInterface.new(input: mock_user_input,
                                            output: mock_console)
    game_settings = GameSettings.new(user_interface: mock_user_interface)
    game_settings.select_game_mode
    game_settings.select_playing_order
    game_engine = new_game_engine(user_interface: mock_user_interface, 
                                  game_settings: game_settings)

    game_engine.play
  
    expect(mock_console).to have_received(:puts)
      .with announce_winner('Computer') + VISUAL_BOARD[:machine_wins]
  end

end
