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

  context 'When the cpu_player could win' do

    it 'returns the winning move (row example)' do
      cpu_one = described_class.new(flag: 'o')
      winnable_board = Board.new
      moves = [[[0,0], 'o'], [[1,0], 'x'], [[0,1], 'o'], [[1,1], 'x']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [0,2]
    end

    it 'returns the winning move (column example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      moves = [[[1,0], 'x'], [[0,2], 'o'], [[2,0], 'x'], [[1,1], 'o']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [0,0]
    end

    it 'returns the winning move (diagonal example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      moves = [[[1,1], 'x'], [[0,2], 'o'], [[0,0], 'x'], [[1,0], 'o']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [2,2]
    end

  end

  context 'When the opponent could win' do

    it 'returns the blocking move (row example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      moves = [[[0,0], 'x'], [[1,1], 'o'], [[2,2], 'x'], [[1,2], 'o']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [1,0]
    end

    it 'returns the blocking move (column example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      moves = [[[0,2], 'x'], [[1,0], 'o'], [[2,1], 'x'], [[2,0], 'o']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [0,0]
    end

    it 'returns the blocking move (diagonal example)' do
      cpu_one = described_class.new(flag: 'x')
      winnable_board = Board.new
      moves = [[[0,2], 'x'], [[1,1], 'o'], [[2,1], 'x'], [[0,0], 'o']]
      update_board_with_moves(winnable_board, moves)

      expect(cpu_one.next_move(winnable_board)).to eq [2,2]
    end

  end

  context 'When a fork is available' do

    it 'returns the forking move' do
      cpu_one = described_class.new(flag: 'x')
      forkable_board = Board.new
      moves = [[[0,0], 'x'], [[1,1], 'o'], [[1,1], 'x'], [[2,2], 'o']]
      update_board_with_moves(forkable_board, moves)

      expect(cpu_one.next_move(forkable_board)).to eq [0,1]
    end

  end

  context 'When a fork is available to the opponent' do

    it 'returns the fork-blocking move' do
      cpu_one = described_class.new(flag: 'x')
      forkable_board = Board.new
      moves = [[[0,0], 'o'], [[1,1], 'x'], [[2,2], 'o']]
      update_board_with_moves(forkable_board, moves)

      expect(cpu_one.next_move(forkable_board)).to eq [0,1]
    end

  end

end
