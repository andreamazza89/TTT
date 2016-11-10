describe UserInterface, '#welcome' do

  it 'sends the welcome message to the output stream' do
    mock_console = spy('Console')
    ui = new_user_interface(output: mock_console)

    ui.welcome

    expect(mock_console).to have_received(:puts).with GAME_PROMPTS[:welcome]
  end
end 


describe UserInterface, '#announce_draw' do

  it 'sends the draw message with the printed board to the output stream' do
    mock_console = spy('Console')
    mock_printer = class_double('BoardPrinter', stringify_board: 'board as a string')
    mock_board = instance_double('Board')
    ui = new_user_interface(output: mock_console, board_printer: mock_printer)

    ui.announce_draw(mock_board)

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:announce_draw] + 'board as a string'
  end
end


describe UserInterface, '#announce_winner' do

  it 'sends the win message with name/printed board to the output stream' do
    mock_console = spy('Console')
    mock_winner = instance_double('HumanPlayer', name: 'Andrea')
    mock_printer = class_double('BoardPrinter', stringify_board: 'board as a string')
    mock_board = instance_double('Board')
    ui = new_user_interface(output: mock_console, board_printer: mock_printer)

    ui.announce_winner(mock_winner, mock_board)

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:announce_winner] + 'Andrea' + 'board as a string'
  end
end


describe UserInterface, '#ask_for_next_move' do

  it 'sends the next_move prompt to the output stream' do
    mock_console = spy('Console')
    mock_next_player = instance_double('HumanPlayer', name: 'Andrea')
    mock_printer = class_double('BoardPrinter', stringify_board: 'board as a string')
    mock_board = instance_double('Board')
    ui = new_user_interface(output: mock_console, board_printer: mock_printer)

    ui.ask_for_next_move(mock_next_player, mock_board)

    expect(mock_console).to have_received(:puts)
      .with 'Andrea' + GAME_PROMPTS[:ask_for_next_move] + 'board as a string'
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

  
describe UserInterface, '#invalid_game_mode_selection' do
  it 'sends the invalid_game_mode_selection prompt to the output stream' do
    mock_console = spy('Console')
    ui = new_user_interface(output: mock_console)

    ui.invalid_game_mode_selection

    expect(mock_console).to have_received(:puts)
      .with GAME_PROMPTS[:invalid_game_mode_selection]
  end
end
