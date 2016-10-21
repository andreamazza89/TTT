describe HumanPlayer, '#name' do

  it 'returns the players id' do
    player_1 = described_class.new(name: '1')
    player_2 = described_class.new(name: '2')

    expect(player_1.name).to eq('1')
    expect(player_2.name).to eq('2')
  end

end

describe HumanPlayer, '#next_move' do

  it 'sends :gets to the given input stream to get the move' do
    mock_user_input = spy('User input')
    player_1 = described_class.new(input: mock_user_input )

    player_1.next_move

    expect(mock_user_input).to have_received(:gets)
  end

  it 'returns the string received from the input stream, chomped' do
    mock_user_input = double('User input', gets: "A1\n")
    player_1 = described_class.new(input: mock_user_input )

    expect(player_1.next_move).to eq('A1')
  end

end

describe HumanPlayer, '#flag' do

  it 'returns the players flag' do
    player_1 = described_class.new(flag: 'x')

    expect(player_1.flag).to eq('x')
  end

end

