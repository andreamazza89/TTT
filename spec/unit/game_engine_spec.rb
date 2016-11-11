describe GameEngine, '#next_turn' do
  it 'asks the current player for a move and sends it to the board' do
    mock_user_interface = spy('Console')
    mock_board = spy('Board')
    mock_player = instance_double('Player', next_move: [0,0], flag: 'x')
    game_engine = described_class.new(user_interface: mock_user_interface, 
                                      board: mock_board)
    game_engine.players = [mock_player]

    game_engine.next_turn
    
    expect(mock_board).to have_received(:add_move!).with([0,0], 'x')
  end
end


describe GameEngine, '#change_turn' do

  it 'swaps the players in the players array' do
    game_engine = described_class.new({})
    game_engine.players = [1,2]
  
    game_engine.change_turn

    expect(game_engine.players).to eq [2,1]
  end
end


describe GameEngine, '#play' do

  context 'When the game is over' do
    it 'announces the outcome (draw)' do
      mock_user_interface = spy('Console')
      mock_board = instance_double('Board', game_over?: true, winner_flag: nil)
      game_engine = described_class.new(user_interface: mock_user_interface, 
                                        board: mock_board)

      game_engine.play

      expect(mock_user_interface).to have_received(:announce_draw).with(mock_board)
    end

    it 'announces the outcome (winner)' do
      mock_user_interface = spy('Console')
      mock_board = instance_double('Board', game_over?: true, winner_flag: 'x')
      game_engine = described_class.new(user_interface: mock_user_interface, 
                                        board: mock_board)
      mock_player = instance_double('Player', flag: 'x')
      game_engine.players = [mock_player]

      game_engine.play

      expect(mock_user_interface).to have_received(:announce_winner).with(mock_player, mock_board)
    end
  end
end
