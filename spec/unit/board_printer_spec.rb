describe BoardPrinter, '#stringify_board' do

  it 'prints the board (empty example)' do
    empty_board = Board.new

    visualised_board = described_class.stringify_board(empty_board)
    expect(visualised_board).to eq VISUAL_BOARD[:no_moves]
  end

  it 'prints the board (draw example)' do
    draw_board = Board.new
    moves = [[[0,0], 'x'], [[0,1], 'o'], [[0,2], 'x'], 
             [[1,1], 'o'], [[1,0], 'x'], [[1,2], 'o'], 
             [[2,1], 'x'], [[2,0], 'o'], [[2,2], 'x']] 
    update_board_with_moves(draw_board, moves)

    visualised_board = described_class.stringify_board(draw_board)
    expect(visualised_board).to eq VISUAL_BOARD[:draw]
  end

end
