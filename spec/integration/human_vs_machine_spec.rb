describe 'Integration - human v machine' do

  let(:mock_console) { spy('Console') }

  it 'Machine beats human if given a chance' do
    mock_user_input = readable_moves("2", "Y", "C2", "C1")
    game_engine = create_game_engine(mock_user_input, mock_console)

    game_engine.play
  
    expect(mock_console).to have_received(:puts)
      .with announce_winner('Computer') + VISUAL_BOARD[:machine_wins]
  end

end
