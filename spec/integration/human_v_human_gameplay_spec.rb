describe 'Integration - human v human' do

  let(:mock_console) { spy('Console') }

  context 'At the start of the game, with no custom configuration' do

    it 'Asks the player for a move and shows the board' do
      mock_user_input = readable_moves("A1")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with prompt_for_input('Player 1') + VISUAL_BOARD[:no_moves]
    end

    it 'Updates the board with first move' do
      mock_user_input = readable_moves("A1", "B2")
      game_engine = new_game_engine(input: mock_user_input)

      game_engine.next_turn
      game_engine.next_turn
      
      expect(mock_console).to have_received(:puts)
        .with prompt_for_input('Player 2') + VISUAL_BOARD[:one_move]
    end

  end

  def readable_moves(*moves)
    all_moves_in_one_string = moves.join("\n")
    StringIO.new(all_moves_in_one_string)
  end

  def new_game_engine(arguments)
    GameEngine.new(input: arguments[:input], output: mock_console)
  end

  def prompt_for_input(player_name)
    player_name + ", it's your turn, have a look at the board and pick a move:\n"
  end
end
