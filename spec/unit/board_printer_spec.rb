describe BoardPrinter, '#stringify_board' do

  it 'prints the board (empty example)' do
    empty_board = Board.new

    visualised_board = described_class.stringify_board(empty_board)
    expect(visualised_board).to eq VISUAL_BOARD[:no_moves]
  end

  it 'prints the board (draw example)' do
    draw_board = Board.new
    draw_board.add_move('A1', 'x')
    draw_board.add_move('A2', 'o')
    draw_board.add_move('A3', 'x')
    draw_board.add_move('B2', 'o')
    draw_board.add_move('B1', 'x')
    draw_board.add_move('B3', 'o')
    draw_board.add_move('C2', 'x')
    draw_board.add_move('C1', 'o')
    draw_board.add_move('C3', 'x')

    visualised_board = described_class.stringify_board(draw_board)
    expect(visualised_board).to eq VISUAL_BOARD[:draw]
  end

end
