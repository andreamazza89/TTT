describe GameEngine, '#next_turn' do

  xit 'sends #ask_for_next_move to the injected user_interface' do
    mock_console = spy('console')
    game_engine = create_game_engine(input: mock_console)

    game_engine.next_turn

    expect(mock_console).to have_received(:ask_for_next_move)
  end
end
