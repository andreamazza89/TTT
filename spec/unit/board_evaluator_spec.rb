describe BoardEvaluator, '#game_over?' do

  context 'When the board is full' do

    it 'returns true' do
      full_board_state = [['x', 'o', 'o'],['x', 'x', 'o'],['o', 'x','x']]

      expect(described_class.game_over?(full_board_state)).to be true
    end

  end

  context 'When the board is not full' do

    it 'returns false if no one has won yet' do
      partial_board_state = [['x', 'o', 'o'],['x', 'x', 'o'],['o', 'x', nil]]

      expect(described_class.game_over?(partial_board_state)).to be false
    end

    it 'returns true if a player has won (row)' do
      partial_board_state = [['x', 'o', 'o'],['x', 'x', 'x'],[nil, 'o', nil]]

      expect(described_class.game_over?(partial_board_state)).to be true
    end

    it 'returns true if a player has won (column)' do
      partial_board_state = [['x', 'o', 'o'],['x', 'x', 'o'],['x', 'o', nil]]

      expect(described_class.game_over?(partial_board_state)).to be true
    end

    it 'returns true if a player has won (downward diagonal)' do
      partial_board_state = [['x', nil, nil],['o', 'x', 'o'],[nil, nil, 'x']]

      expect(described_class.game_over?(partial_board_state)).to be true
    end

    it 'returns true if a player has won (upward diagonal)' do
      partial_board_state = [['x', nil, 'o'],[nil, 'o', 'o'],['o', 'x', 'x']]

      expect(described_class.game_over?(partial_board_state)).to be true
    end

  end
end
