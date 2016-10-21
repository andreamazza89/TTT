require 'human_player'

describe HumanPlayer, '#name' do

  it 'returns the players id' do
    player_1 = described_class.new(name: '1')
    player_2 = described_class.new(name: '2')
    expect(player_1.name).to eq('1')
    expect(player_2.name).to eq('2')
  end

end
