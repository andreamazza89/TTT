describe BoardEvaluator, '#game_over?' do

  context 'When the board is full' do

    it 'returns true' do
      mock_full_board = Board.new
      mock_full_board.add_move('A1', 'x')
      mock_full_board.add_move('A2', 'o')
      mock_full_board.add_move('A3', 'x')
      mock_full_board.add_move('B1', 'o')
      mock_full_board.add_move('B2', 'x')
      mock_full_board.add_move('B3', 'o')
      mock_full_board.add_move('C1', 'x')
      mock_full_board.add_move('C2', 'o')
      mock_full_board.add_move('C3', 'x')

      expect(described_class.game_over?(mock_full_board)).to be true
    end

  end

  context 'When the board is not full' do

    it 'returns false with an empty board' do
      mock_empty_board = Board.new

      expect(described_class.game_over?(mock_empty_board)).to be false
    end

    it 'returns false if no one has won yet' do
      mock_partial_board = Board.new
      mock_partial_board.add_move('A1', 'x')
      mock_partial_board.add_move('A2', 'o')
      mock_partial_board.add_move('A3', 'x')

      expect(described_class.game_over?(mock_partial_board)).to be false
    end

    it 'returns true if a player has won (row)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('A1', 'x')
      mock_board_winner.add_move('B1', 'o')
      mock_board_winner.add_move('A2', 'x')
      mock_board_winner.add_move('B2', 'o')
      mock_board_winner.add_move('A3', 'x')

      expect(described_class.game_over?(mock_board_winner)).to be true
    end

    it 'returns true if a player has won (column)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('A1', 'x')
      mock_board_winner.add_move('A2', 'o')
      mock_board_winner.add_move('B1', 'x')
      mock_board_winner.add_move('A3', 'o')
      mock_board_winner.add_move('C1', 'x')

      expect(described_class.game_over?(mock_board_winner)).to be true
    end

    it 'returns true if a player has won (downward diagonal)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('A1', 'x')
      mock_board_winner.add_move('A2', 'o')
      mock_board_winner.add_move('B2', 'x')
      mock_board_winner.add_move('A3', 'o')
      mock_board_winner.add_move('C3', 'x')

      expect(described_class.game_over?(mock_board_winner)).to be true
    end

    it 'returns true if a player has won (upward diagonal)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('C1', 'x')
      mock_board_winner.add_move('A1', 'o')
      mock_board_winner.add_move('B2', 'x')
      mock_board_winner.add_move('A2', 'o')
      mock_board_winner.add_move('A3', 'x')

      expect(described_class.game_over?(mock_board_winner)).to be true
    end

  end
end

describe BoardEvaluator, '#winner_flag' do

  context 'When a winner exists' do

    it 'returns the winning flag (naughts wins)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('A1', 'x')
      mock_board_winner.add_move('B1', 'o')
      mock_board_winner.add_move('A2', 'x')
      mock_board_winner.add_move('B2', 'o')
      mock_board_winner.add_move('A3', 'x')

      expect(described_class.winner_flag(mock_board_winner)).to eq('x')
    end

    it 'returns the winning flag (crosses wins)' do
      mock_board_winner = Board.new
      mock_board_winner.add_move('A1', 'o')
      mock_board_winner.add_move('B1', 'x')
      mock_board_winner.add_move('A2', 'o')
      mock_board_winner.add_move('B2', 'x')
      mock_board_winner.add_move('A3', 'o')

      expect(described_class.winner_flag(mock_board_winner)).to eq('o')
    end

  end

  context 'When there is no winner' do

    it 'returns nil' do
      mock_board_no_winner = Board.new
      mock_board_no_winner.add_move('A1', 'x')
      mock_board_no_winner.add_move('A2', 'o')
      mock_board_no_winner.add_move('A3', 'x')

      expect(described_class.winner_flag(mock_board_no_winner)).to eq(nil)
    end

  end

end
