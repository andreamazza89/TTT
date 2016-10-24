describe Board, '#board_state' do

  it 'returns an empty board before any moves are added' do
    board = described_class.new

    expect(board.board_state).to eq [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

end

describe Board, '#rows', focus: true do

  it 'returns all rows' do
    board = described_class.new

    expect(board.rows).to eq [[Cell.new(row: 0, column: 0), Cell.new(row: 0, column: 1), Cell.new(row: 0, column: 2)], 
                              [Cell.new(row: 1, column: 0), Cell.new(row: 1, column: 1), Cell.new(row: 1, column: 2)],
                              [Cell.new(row: 2, column: 0), Cell.new(row: 2, column: 1), Cell.new(row: 2, column: 2)]]
  end

end

describe Board, '#add_move' do

  it 'updates the board state with the cell/flag provided' do
    board = described_class.new

    board.add_move('A1', 'x') 
    board.add_move('B2', 'o') 

    expect(board.board_state).to eq [['x', nil, nil], [nil, 'o', nil], [nil, nil, nil]]
  end

end
