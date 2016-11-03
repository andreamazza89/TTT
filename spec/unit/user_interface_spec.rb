describe UserInterface, '#welcome' do

  it 'sends the welcome message to the output stream' do
    mock_console = spy('Console')
    ui = new_user_interface(output: mock_console)

    ui.welcome

    expect(mock_console).to have_received(:puts).with GAME_PROMPTS[:welcome]
  end
end 


describe UserInterface, '#announce_draw' do

  it 'sends the draw message with the additional message to the output stream' do
    mock_console = spy('Console')
    mock_final_board = 'a string representation of the final board state'
    ui = new_user_interface(output: mock_console)

    ui.announce_draw(mock_final_board)

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:announce_draw] + mock_final_board
  end
end


describe UserInterface, '#announce_winner' do

  it 'sends the win message with name/additional message to the output stream' do
    mock_console = spy('Console')
    mock_winner = 'this is the winners name'
    mock_final_board = 'a string representation of the final board state'
    ui = new_user_interface(output: mock_console)

    ui.announce_winner(mock_winner, mock_final_board)

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:announce_winner] + mock_winner + mock_final_board
  end
end


describe UserInterface, '#ask_for_next_move' do

  it 'sends the next_move prompt to the output stream' do
    mock_console = spy('Console')
    mock_next_player = 'this is the players whose turn is name'
    mock_board = 'this is a string representation of the current board state'
    ui = new_user_interface(output: mock_console)

    ui.ask_for_next_move(mock_next_player, mock_board)

    expect(mock_console).to have_received(:puts)
      .with mock_next_player + GAME_PROMPTS[:ask_for_next_move] + mock_board
  end
end


describe UserInterface, '#get_next_move' do

  it 'returns the move (chomped) from the given input stream' do
    mock_user_input = readable_moves("A1")
    mock_next_player = 'this is the players whose turn is name'
    mock_board = 'this is a string representation of the current board state'
    ui = new_user_interface(input: mock_user_input)

    expect(ui.get_next_move).to eq "A1"
  end
end


describe UserInterface, '#invalid_input' do
  it 'sends the try_again prompt with reason for bad input to the output stream' do
    mock_console = spy('Console')
    mock_reason = 'reason why the input is not valid'
    ui = new_user_interface(output: mock_console)

    ui.invalid_input(mock_reason)

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:please_try_again] + mock_reason
  end
end


describe UserInterface, '#select_game_mode' do
  it 'sends the select_mode prompt to the output stream' do
    mock_console = spy('Console')
    ui = new_user_interface(output: mock_console)

    ui.select_game_mode

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:game_mode_selection]
  end

  it 'returns the selected mode (chomped) from the given input stream' do
    mock_user_input = readable_moves("1")
    ui = new_user_interface(input: mock_user_input)

    expect(ui.select_game_mode).to eq "1"
  end
end


describe UserInterface, '#select_playing_order' do
  it 'sends the select_order prompt to the output stream' do
    mock_console = spy('Console')
    ui = new_user_interface(output: mock_console)

    ui.select_playing_order

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:play_order_selection]
  end

  it 'returns the selected mode (chomped) from the given input stream' do
    mock_user_input = readable_moves("Y")
    ui = new_user_interface(input: mock_user_input)

    expect(ui.select_playing_order).to eq "Y"
  end
end
