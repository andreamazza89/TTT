describe HumanPlayer, '#name' do

  it 'returns the players id' do
    player_one = described_class.new(name: '1')
    player_two = described_class.new(name: '2')

    expect(player_one.name).to eq('1')
    expect(player_two.name).to eq('2')
  end

end

describe HumanPlayer, '#flag' do

  it 'returns the players flag' do
    player_one = described_class.new(flag: 'x')

    expect(player_one.flag).to eq('x')
  end

end

describe HumanPlayer, '#next_move', focus: true do

  it 'sends :gets to the given input stream to get the move' do
    mock_user_input = spy('User input')
    player_one = described_class.new(input: mock_user_input )

    player_one.next_move

    expect(mock_user_input).to have_received(:gets)
  end

  it 'returns the input string, converted into a board move (example 1)' do
    mock_user_input = double('User input', gets: "A1\n")
    player_one = described_class.new(input: mock_user_input)

    expect(player_one.next_move).to eq([0,0])
  end

  it 'returns the input string, converted into a board move (example 2)' do
    mock_user_input = double('User input', gets: "B2\n")
    player_one = described_class.new(input: mock_user_input)

    expect(player_one.next_move).to eq([1,1])
  end

end
