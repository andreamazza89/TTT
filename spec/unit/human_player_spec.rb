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


describe HumanPlayer, '#next_move' do

  context 'Default' do
    it 'sends :gets to the given input stream to get the move' do
      mock_user_input = spy('User input', gets: "A1\n")
      player_one = described_class.new(input: mock_user_input )
      board = Board.new

      player_one.next_move(board)

      expect(mock_user_input).to have_received(:gets)
    end
  end


  context 'When the input is valid' do
    it 'returns the input string, converted into a board move (example 1)' do
      mock_user_input = double('User input', gets: "A1\n")
      player_one = described_class.new(input: mock_user_input)
      board = Board.new

      expect(player_one.next_move(board)).to eq([0,0])
    end

    it 'returns the input string, converted into a board move (example 2)' do
      mock_user_input = double('User input', gets: "B2\n")
      player_one = described_class.new(input: mock_user_input)
      board = Board.new

      expect(player_one.next_move(board)).to eq([1,1])
    end
  end


  context 'When the input is invalid' do
    it 'raises an invalid move exception (move already taken)' do
      mock_user_input = double('User input', gets: "A1")
      player_one = described_class.new(input: mock_user_input)
      board = Board.new
      board.add_move!([0,0], 'x')

      expect{ player_one.next_move(board) }.to raise_error(InvalidMove::CellAlreadyTaken)
    end

    it 'raises an invalid move exception (illegal input)' do
      mock_user_input = double('User input', gets: "ZZTop")
      player_one = described_class.new(input: mock_user_input)
      board = Board.new

      expect{ player_one.next_move(board) }.to raise_error(InvalidMove::IllegalInput)
    end
  end
end
