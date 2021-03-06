describe Board, '#rows' do

  it 'returns an array of rows' do
    board = described_class.new

    expect(board.rows).to eq [[Cell.new(row: 0, column: 0), 
                               Cell.new(row: 0, column: 1), 
                               Cell.new(row: 0, column: 2)],
                              [Cell.new(row: 1, column: 0),  
                               Cell.new(row: 1, column: 1), 
                               Cell.new(row: 1, column: 2)],
                              [Cell.new(row: 2, column: 0), 
                               Cell.new(row: 2, column: 1), 
                               Cell.new(row: 2, column: 2)]]
  end
end


describe Board, '#columns' do

  it 'returns an array of columns' do
    board = described_class.new

    expect(board.columns).to eq [[Cell.new(row: 0, column: 0), 
                                  Cell.new(row: 1, column: 0), 
                                  Cell.new(row: 2, column: 0)],
                                 [Cell.new(row: 0, column: 1),  
                                  Cell.new(row: 1, column: 1), 
                                  Cell.new(row: 2, column: 1)],
                                 [Cell.new(row: 0, column: 2), 
                                  Cell.new(row: 1, column: 2), 
                                  Cell.new(row: 2, column: 2)]]
  end
end


describe Board, '#diagonals' do

  it 'returns an array of diagonals' do
    board = described_class.new

    expect(board.diagonals).to eq [[Cell.new(row: 0, column: 0), 
                                   Cell.new(row: 1, column: 1), 
                                   Cell.new(row: 2, column: 2)],
                                  [Cell.new(row: 2, column: 0),  
                                   Cell.new(row: 1, column: 1), 
                                   Cell.new(row: 0, column: 2)]]
  end
end


describe Board, '#rows_cols_diags' do

  it 'returns an array of rows, columns and diagonals' do
    board = described_class.new

    expect(board.rows_cols_diags)
      .to eq(board.rows + board.columns + board.diagonals)
  end
end


describe Board, '#add_move!' do

  it 'updates the board state as per the position/flag provided' do
    board = described_class.new

    board.add_move!([0,0], 'x') 

    updated_cell = board.rows.first[0]
    expect(updated_cell.flag).to eq 'x'
  end
end


describe Board, '#add_move' do

  it 'returns a new board updated with the given move without altering the board' do
    original_board = described_class.new

    new_board = original_board.add_move([0,0], 'x') 

    updated_cell = new_board.rows[0][0]
    unchanged_cell = original_board.rows[0][0] 
    expect(updated_cell.flag).to eq 'x'
    expect(unchanged_cell.flag).to eq nil
  end
end


describe Board, '#available_moves' do

  context 'When the board is empty' do
    it 'retuns an array of all possible moves' do
      board = described_class.new

      expect(board.available_moves)
        .to eq([[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]])
    end
  end


  context 'When the board is full' do
    it 'retuns an empty array' do
      full_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o'], 
               [[2,0], 'x'], [[2,1], 'o'], [[2,2], 'x']] 
      update_board_with_moves(full_board, moves)

      expect(full_board.available_moves).to eq([])
    end
  end


  context 'When the board is not full' do
    it 'retuns the appropriate array' do
      board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o']]
                
      update_board_with_moves(board, moves)

      expect(board.available_moves).to eq([[2,0], [2,1], [2,2]])
    end
  end
end


describe Board, '#is_move_available?' do

  it 'returns true for an available move' do
    board = described_class.new
    moves = [[[0,0], 'x']]
              
    update_board_with_moves(board, moves)

    expect(board.is_move_available?([1,1])).to be true
  end

  it 'returns false for a move that is not available' do
    board = described_class.new
    moves = [[[0,0], 'x']]
              
    update_board_with_moves(board, moves)

    expect(board.is_move_available?([0,0])).to be false
  end

  it 'returns false for a move that does not exist' do
    board = described_class.new

    expect(board.is_move_available?([4,4])).to be false
  end
end


describe Board, '#empty?' do

  it 'returns true for a new board' do
    board = described_class.new

    expect(board.empty?).to be true
  end

  it 'returns false if there are any moves on the board' do
    board = described_class.new
    board.add_move!([0,0], 'x')

    expect(board.empty?).to be false
  end
end


describe Board, '#winner_flag' do

  context 'When a winner exists' do
    it 'returns the winning flag (crosses wins)' do
      winner_board = described_class.new
      moves = [[[0,0], 'x'], [[1,0], 'o'], [[0,1], 'x'], 
               [[1,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.winner_flag).to eq('x')
    end

    it 'returns the winning flag (naughts wins)' do
      winner_board = described_class.new
      moves = [[[0,0], 'o'], [[1,0], 'x'], [[0,1], 'o'], 
               [[1,1], 'x'], [[0,2], 'o']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.winner_flag).to eq('o')
    end
  end


  context 'When there is no winner' do
    it 'returns nil' do
      unfinished_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(unfinished_board, moves)

      expect(unfinished_board.winner_flag).to eq(nil)
    end
  end
end


describe Board, '#game_over?' do

  context 'When the board is full' do
    it 'returns true' do
      full_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
               [[1,0], 'o'], [[1,1], 'x'], [[1,2], 'o'], 
               [[2,0], 'x'], [[2,1], 'o'], [[2,2], 'x']] 
      update_board_with_moves(full_board, moves)

      expect(full_board.game_over?).to be true
    end
  end


  context 'When the board is not full' do
    it 'returns false (empty board)' do
      empty_board = described_class.new

      expect(empty_board.game_over?).to be false
    end

    it 'returns false (no one has won yet)' do
      partial_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(partial_board, moves)

      expect(partial_board.game_over?).to be false
    end

    it 'returns true if a player has won (row)' do
      winner_board = described_class.new
      moves = [[[0,0], 'x'], [[1,0], 'o'], [[0,1], 'x'], 
               [[1,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.game_over?).to be true
    end

    it 'returns true if a player has won (column)' do
      winner_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[1,0], 'x'], 
               [[0,2], 'o'], [[2,0], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.game_over?).to be true
    end

    it 'returns true if a player has won (downward diagonal)' do
      winner_board = described_class.new
      moves = [[[0,0], 'x'], [[0,1], 'o'], [[1,1], 'x'], 
               [[0,2], 'o'], [[2,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.game_over?).to be true
    end

    it 'returns true if a player has won (upward diagonal)' do
      winner_board = described_class.new
      moves = [[[2,0], 'x'], [[0,1], 'o'], [[1,1], 'x'], 
               [[0,1], 'o'], [[0,2], 'x']]
      update_board_with_moves(winner_board, moves)

      expect(winner_board.game_over?).to be true
    end
  end
end
