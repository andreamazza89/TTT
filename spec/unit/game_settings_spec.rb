describe GameSettings, '#select_game_mode' do
  
  context 'default' do
    it 'sends #select_game_mode to the user interface' do
      mock_user_interface = instance_double('UserInterface', select_game_mode: "1") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(mock_user_interface).to have_received(:select_game_mode)
    end
  end


  context 'When the user selects Human v Human' do
    it 'sets both players in the engine to be human, with default names/flags' do
      mock_user_interface = instance_double('UserInterface', select_game_mode: "1") 
      mock_game_engine = MockGameEngine.new 
      game_settings = new_game_settings({ user_interface: mock_user_interface,
                                          game_engine: mock_game_engine })
    
      game_settings.select_game_mode

    
      expect(mock_game_engine.player_one).to be_a HumanPlayer
      expect(mock_game_engine.player_one.name).to eq 'Player 1'
      expect(mock_game_engine.player_one.flag).to eq 'x'
      expect(mock_game_engine.player_two).to be_a HumanPlayer
      expect(mock_game_engine.player_two.name).to eq 'Player 2'
      expect(mock_game_engine.player_two.flag).to eq 'o'
    end
  end


  context 'When the user selects Human v Machine' do
    it 'sets one player to be human the other to be machine' do
      mock_user_interface = instance_double('UserInterface', select_game_mode: "2") 
      mock_game_engine = MockGameEngine.new 
      game_settings = new_game_settings({ user_interface: mock_user_interface,
                                          game_engine: mock_game_engine })
    
      game_settings.select_game_mode

    
      expect(mock_game_engine.player_one).to be_a HumanPlayer
      expect(mock_game_engine.player_one.name).to eq 'Player 1'
      expect(mock_game_engine.player_one.flag).to eq 'x'
      expect(mock_game_engine.player_two).to be_a CpuPlayer
      expect(mock_game_engine.player_two.name).to eq 'Computer'
      expect(mock_game_engine.player_two.flag).to eq 'o'
    end
  end


  context 'When the user selects Machine v Machine' do
    it 'sets both players to be machine' do
      mock_user_interface = instance_double('UserInterface', select_game_mode: "3") 
      mock_game_engine = MockGameEngine.new 
      game_settings = new_game_settings({ user_interface: mock_user_interface,
                                          game_engine: mock_game_engine })
    
      game_settings.select_game_mode

    
      expect(mock_game_engine.player_one).to be_a CpuPlayer
      expect(mock_game_engine.player_one.name).to eq 'Computer 1'
      expect(mock_game_engine.player_one.flag).to eq 'x'
      expect(mock_game_engine.player_two).to be_a CpuPlayer
      expect(mock_game_engine.player_two.name).to eq 'Computer 2'
      expect(mock_game_engine.player_two.flag).to eq 'o'
    end
  end

  context 'When the input does not match any available mode' do
    it 'sends :invalid_game_mode_selection to the user interface' do
      mock_user_input = readable_moves("999", "1")
      mock_user_interface = new_user_interface(input: mock_user_input)
      game_settings = new_game_settings(user_interface: mock_user_interface)
    
      expect(mock_user_interface).to receive(:invalid_game_mode_selection)

      game_settings.select_game_mode
    end
  end
end


describe GameSettings, '#select_playing_order' do
  
  context 'default' do
    it 'sends select_playing_order to the user interface' do
      mock_user_interface = spy('UserInterface') 
      game_settings = new_game_settings(user_interface: mock_user_interface)
    
      game_settings.select_playing_order

      expect(mock_user_interface).to have_received(:select_playing_order)
    end
  end


  context 'When the user wants to change the order' do
    it 'reverses the players array (user enters Y)' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "Y") 
      mock_game_engine = MockGameEngine.new
      mock_game_engine.players = [1,2]
      game_settings = new_game_settings(user_interface: mock_user_interface,
                                          game_engine: mock_game_engine)
    
      game_settings.select_playing_order

      expect(mock_game_engine.player_one).to eq 2
      expect(mock_game_engine.player_two).to eq 1
    end

    it 'reverses the players array (user enters y)' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "y") 
      mock_game_engine = MockGameEngine.new
      mock_game_engine.players = [1,2]
      game_settings = new_game_settings(user_interface: mock_user_interface,
                                          game_engine: mock_game_engine)
    
      game_settings.select_playing_order

      expect(mock_game_engine.player_one).to eq 2
      expect(mock_game_engine.player_two).to eq 1
    end
  end


  context 'When the user does not want to change the order' do
    it 'does not reverse the players array' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "N") 
      mock_game_engine = MockGameEngine.new
      mock_game_engine.players = [1,2]
      game_settings = new_game_settings(user_interface: mock_user_interface,
                                          game_engine: mock_game_engine)
    
      game_settings.select_playing_order

      expect(mock_game_engine.player_one).to eq 1
      expect(mock_game_engine.player_two).to eq 2
    end
  end
end
