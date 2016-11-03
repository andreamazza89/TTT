describe 'Integration - Human move input validation' do

  let(:mock_console) { spy('Console') }

  it 'Prompts the player for another move if the one given is illegal' do
    mock_user_input = readable_moves("1", "No", "ZZTop", "A1")
    game_engine = create_game_engine(mock_user_input, mock_console)

    game_engine.next_turn
  
    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:please_try_again] + GAME_PROMPTS[:illegal_move]
  end

  it 'Prompts the player for another move if the one given is already taken' do
    mock_user_input = readable_moves("1", "No", "A1", "A1", "A2")
    game_engine = create_game_engine(mock_user_input, mock_console)

    game_engine.next_turn
    game_engine.next_turn
  
    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:please_try_again] + GAME_PROMPTS[:cell_already_taken]
  end
end
