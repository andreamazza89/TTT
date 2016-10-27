describe 'Integration - human v machine' do

  let(:mock_console) { spy('Console') }

  it 'Machine beats human if given a chance' do
    mock_user_input = readable_moves("2", "N", "A1", "C2", "C3")
    game_engine = new_game_engine(input: mock_user_input)

    game_engine.setup_game_mode
    game_engine.setup_play_order
    game_engine.play
  
    expect(mock_console).to have_received(:puts)
      .with announce_winner('Player 2') + VISUAL_BOARD[:machine_wins]
  end

end
