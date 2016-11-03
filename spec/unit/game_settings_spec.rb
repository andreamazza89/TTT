describe GameSettings, '#players' do

  it 'defaults to an empty array' do
    game_settings = new_game_settings
  
    expect(game_settings.players).to eq []
  end

end


describe GameSettings, '#select_game_mode' do
  
  context 'default' do
    it 'sends #select_game_mode to the user interface' do
      mock_user_interface = spy('UserInterface', select_game_mode: "1") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(mock_user_interface).to have_received(:select_game_mode)
    end
  end


  context 'When the user selects Human v Human' do
    it 'sets both players to be human' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "1") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0]).to be_a HumanPlayer
      expect(game_settings.players[1]).to be_a HumanPlayer
    end

    it 'defaults player names to Player 1 & Player 2' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "1") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].name).to eq 'Player 1'
      expect(game_settings.players[1].name).to eq 'Player 2'
    end

    it 'defaults player flags to x & o' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "1") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].flag).to eq 'x'
      expect(game_settings.players[1].flag).to eq 'o'
    end
  end


  context 'When the user selects Human v Machine' do
    it 'sets one player to be human the other to be machine' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "2") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0]).to be_a HumanPlayer
      expect(game_settings.players[1]).to be_a CpuPlayer
    end

    it 'defaults player names to Player 1 & Computer' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "2") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].name).to eq 'Player 1'
      expect(game_settings.players[1].name).to eq 'Computer'
    end

    it 'defaults player flags to x & o' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "2") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].flag).to eq 'x'
      expect(game_settings.players[1].flag).to eq 'o'
    end
  end


  context 'When the user selects Machine v Machine' do
    it 'sets both players to be machine' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "3") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0]).to be_a CpuPlayer
      expect(game_settings.players[1]).to be_a CpuPlayer
    end

    it 'defaults player names to Computer 1 & Computer 2' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "3") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].name).to eq 'Computer 1'
      expect(game_settings.players[1].name).to eq 'Computer 2'
    end

    it 'defaults player flags to x & o' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_game_mode: "3") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_game_mode

      expect(game_settings.players[0].flag).to eq 'x'
      expect(game_settings.players[1].flag).to eq 'o'
    end
  end

  context 'When the input does not match any available mode' do
    it 'sends :invalid_game_mode_selection to the user interface' do
      mock_user_input = readable_moves("999", "1")
      mock_user_output = double('Console', puts: nil)
      mock_user_interface = UserInterface.new(input: mock_user_input, 
                                              output: mock_user_output)
                                              
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      expect(mock_user_interface).to receive(:invalid_game_mode_selection)

      game_settings.select_game_mode
    end
  end
end


describe GameSettings, '#select_playing_order' do
  
  context 'default' do
    it 'sends select_playing_order to the user interface' do
      mock_user_interface = spy('UserInterface') 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
    
      game_settings.select_playing_order

      expect(mock_user_interface).to have_received(:select_playing_order)
    end
  end


  context 'When the user wants to change the order' do
    it 'reverses the players array (user enters Y)' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "Y") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
      game_settings.players = [1,2]
    
      game_settings.select_playing_order

      expect(game_settings.players[0]).to eq 2
      expect(game_settings.players[1]).to eq 1
    end

    it 'reverses the players array (user enters y)' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "y") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
      game_settings.players = [1,2]
    
      game_settings.select_playing_order

      expect(game_settings.players[0]).to eq 2
      expect(game_settings.players[1]).to eq 1
    end
  end


  context 'When the user does not want to change the order' do
    it 'does not reverse the players array' do
      mock_user_interface = instance_double('UserInterface', 
                                             select_playing_order: "N") 
      game_settings = new_game_settings({ user_interface: mock_user_interface })
      game_settings.players = [1,2]
    
      game_settings.select_playing_order

      expect(game_settings.players[0]).to eq 1
      expect(game_settings.players[1]).to eq 2
    end
  end
end


describe GameSettings, '#apply_settings' do
  
  it 'assigns the players array to the given argument (example one)' do
    game_settings = new_game_settings
    game_settings.players = [1,2]
    game_engine = spy('game engine')

    game_settings.apply_settings(game_engine)

    expect(game_engine).to have_received(:players=).with [1,2]
  end

  it 'assigns the players array to the given argument (example two)' do
    game_settings = new_game_settings
    game_settings.players = [3,4]
    game_engine = spy('game engine')

    game_settings.apply_settings(game_engine)

    expect(game_engine).to have_received(:players=).with [3,4]
  end
end
