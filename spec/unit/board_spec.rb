describe Board, '#print_status' do

  it 'prints the board (empty example)' do
    board = described_class.new

    expect(board.stringified_status).to eq BOARDS_AS_STRINGS[:empty_board]
  end

end

describe Board, '#add_move' do

  it 'updates the board state with the cell/flag provided' do
    board = described_class.new

    board.add_move('A1', 'x') 
    board.add_move('B2', 'o') 

    expect(board.stringified_status).to eq BOARDS_AS_STRINGS[:two_moves]
  end

end
