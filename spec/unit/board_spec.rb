describe Board, '#add_move' do

  it 'updates the board state with the cell/flag provided' do
    board = described_class.new

    board.add_move('A1', 'x') 
    board.add_move('B2', 'o') 

    expect(board.board_state).to eq [['x', nil, nil], [nil, 'o', nil], [nil, nil, nil]]
  end

end
