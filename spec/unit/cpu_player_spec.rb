describe CpuPlayer, '#name' do

  it 'returns the player id' do
    cpu_one = described_class.new(name: '1')
    cpu_two = described_class.new(name: '2')

    expect(cpu_one.name).to eq('1')
    expect(cpu_two.name).to eq('2')
  end

end

describe CpuPlayer, '#flag' do

  it 'returns the players flag' do
    cpu_one = described_class.new(flag: 'x')

    expect(cpu_one.flag).to eq('x')
  end

end

describe CpuPlayer, '#next_move' do

  context 'When the cpu_player can win' do

    it 'returns the winning move (row example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move('A1', 'x')
      winnable_board.add_move('B1', 'o')
      winnable_board.add_move('A2', 'x')
      winnable_board.add_move('B2', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "A3"
    end

    it 'returns the winning move (column example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move('B1', 'x')
      winnable_board.add_move('A3', 'o')
      winnable_board.add_move('C1', 'x')
      winnable_board.add_move('B2', 'o')


      expect(cpu_one.next_move(winnable_board)).to eq "A1"
    end

    it 'returns the winning move (diagonal example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move('B2', 'x')
      winnable_board.add_move('A3', 'o')
      winnable_board.add_move('A1', 'x')
      winnable_board.add_move('B1', 'o')


      expect(cpu_one.next_move(winnable_board)).to eq "C3"
    end

  end

end
