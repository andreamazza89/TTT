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

describe CpuPlayer, '#next_move', focus: true do

  context 'When the cpu_player could win' do

    it 'returns the winning move (row example)' do
      cpu_one = described_class.new(flag: 'o')
      winnable_board = Board.new
      winnable_board.add_move!('A1', 'o')
      winnable_board.add_move!('B1', 'x')
      winnable_board.add_move!('A2', 'o')
      winnable_board.add_move!('B2', 'x')

      expect(cpu_one.next_move(winnable_board)).to eq "A3"
    end

    it 'returns the winning move (column example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move!('B1', 'x')
      winnable_board.add_move!('A3', 'o')
      winnable_board.add_move!('C1', 'x')
      winnable_board.add_move!('B2', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "A1"
    end

    it 'returns the winning move (diagonal example)' do
      cpu_one = described_class.new(flag: 'x')
      boardy = Board.new
      boardy.add_move!('B2', 'x')
      boardy.add_move!('A3', 'o')
      boardy.add_move!('A1', 'x')
      boardy.add_move!('B1', 'o')


      expect(cpu_one.next_move(boardy)).to eq "C3"
    end

  end

  context 'When the opponent could win' do

    it 'returns the blocking move (row example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move!('A1', 'x')
      winnable_board.add_move!('B2', 'o')
      winnable_board.add_move!('C3', 'x')
      winnable_board.add_move!('B3', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "B1"
    end

    it 'returns the blocking move (column example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move!('A3', 'x')
      winnable_board.add_move!('B1', 'o')
      winnable_board.add_move!('C2', 'x')
      winnable_board.add_move!('C1', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "A1"
    end

    it 'returns the blocking move (diagonal example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move!('A3', 'x')
      winnable_board.add_move!('B2', 'o')
      winnable_board.add_move!('C2', 'x')
      winnable_board.add_move!('A1', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "C3"
    end

  end

  context 'When a fork is available' do

    it 'returns the forking move (row example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      winnable_board.add_move!('A1', 'x')
      winnable_board.add_move!('B1', 'o')
      winnable_board.add_move!('B2', 'x')
      winnable_board.add_move!('C3', 'o')

      expect(cpu_one.next_move(winnable_board)).to eq "A2"
    end

  end

end
