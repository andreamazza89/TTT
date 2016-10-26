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

describe Board, '#add_move!' do

  it 'updates the board state with the cell/flag provided' do
    board = described_class.new

    board.add_move!('A1', 'x') 

    updated_cell = board.rows[0][0]
    expect(updated_cell.flag).to eq 'x'
  end

end

describe Board, '#add_move' do

  it 'returns a new board updated with the given move without altering the board' do
    original_board = described_class.new

    new_board = original_board.add_move('A1', 'x') 

    updated_cell = new_board.rows[0][0]
    unchanged_cell = original_board.rows[0][0] 
    expect(updated_cell.flag).to eq 'x'
    expect(unchanged_cell.flag).to eq nil
  end

end
