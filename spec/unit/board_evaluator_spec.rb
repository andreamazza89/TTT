describe BoardEvaluator, '#game_over?' do

  context 'When the board is full' do
    it 'returns true' do
      full_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o'], 
               [[2,0], 'x'], [[2,1], 'o'], [[2,2], 'x']] 
      update_board_with_moves(full_board, moves)

      expect(described_class.game_over?(full_board)).to be true
    end
  end


  context 'When the board is not full' do
    it 'returns false (empty board)' do
      empty_board = Board.new

      expect(described_class.game_over?(empty_board)).to be false
    end

    it 'returns false (no one has won yet)' do
      partial_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(partial_board, moves)

      expect(described_class.game_over?(partial_board)).to be false
    end

    it 'returns true if a player has won (row)' do
      winner_board = Board.new
      moves = [[[0,0], 'x'], [[1,0], 'o'], [[0,1], 'x'], 
               [[1,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.game_over?(winner_board)).to be true
    end

    it 'returns true if a player has won (column)' do
      winner_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[1,0], 'x'], 
               [[0,2], 'o'], [[2,0], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.game_over?(winner_board)).to be true
    end

    it 'returns true if a player has won (downward diagonal)' do
      winner_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[1,1], 'x'], 
               [[0,2], 'o'], [[2,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.game_over?(winner_board)).to be true
    end

    it 'returns true if a player has won (upward diagonal)' do
      winner_board = Board.new
      moves = [[[2,0], 'x'], [[0,1], 'o'], [[1,1], 'x'], 
               [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.game_over?(winner_board)).to be true
    end
  end
end


describe BoardEvaluator, '#winner_flag' do

  context 'When a winner exists' do
    it 'returns the winning flag (crosses wins)' do
      winner_board = Board.new
      moves = [[[0,0], 'x'], [[1,0], 'o'], [[0,1], 'x'], 
               [[1,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.winner_flag(winner_board)).to eq('x')
    end

    it 'returns the winning flag (naughts wins)' do
      winner_board = Board.new
      moves = [[[0,0], 'o'], [[1,0], 'x'], [[0,1], 'o'], 
               [[1,1], 'x'], [[0,2], 'o']]
      update_board_with_moves(winner_board, moves)

      expect(described_class.winner_flag(winner_board)).to eq('o')
    end
  end


  context 'When there is no winner' do
    it 'returns nil' do
      unfinished_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(unfinished_board, moves)

      expect(described_class.winner_flag(unfinished_board)).to eq(nil)
    end
  end
end


describe BoardEvaluator, '#available_moves' do

  context 'When the board is empty' do
    it 'retuns an array of all possible moves' do
      board = Board.new

      expect(described_class.available_moves(board))
        .to eq([[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]])
    end
  end


  context 'When the board is full' do
    it 'retuns an empty array' do
      full_board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o'], 
               [[2,0], 'x'], [[2,1], 'o'], [[2,2], 'x']] 
      update_board_with_moves(full_board, moves)

      expect(described_class.available_moves(full_board))
        .to eq([])
    end
  end


  context 'When the board is not full' do
    it 'retuns the appropriate array' do
      board = Board.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o']]
                
      update_board_with_moves(board, moves)

      expect(described_class.available_moves(board))
        .to eq([[2,0], [2,1], [2,2]])
    end
  end
end


describe BoardEvaluator, '#empty?' do

  it 'returns true for a new board' do
    board = Board.new

    expect(described_class.empty?(board)).to be true
  end

  it 'returns false if there are any moves on the board' do
    board = Board.new
    board.add_move!([0,0], 'x')

    expect(described_class.empty?(board)).to be false
  end

end
