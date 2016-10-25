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

    it 'returns the winning move (row example 1)' do
      cpu_one = described_class.new(flag: 'x')
      board_state = [['x', 'x', nil], ['o', 'o', nil], [nil, nil, nil]]

      expect(cpu_one.next_move(board_state)).to eq "A3"
    end

    it 'returns the winning move (row example 2)' do
      cpu_one = described_class.new(flag: 'o')
      board_state = [['x', 'x', nil], ['o', 'o', nil], [nil, nil, nil]]

      expect(cpu_one.next_move(board_state)).to eq "B3"
    end

  end

end
