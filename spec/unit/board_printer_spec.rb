describe BoardPrinter, '#stringify_board' do

  it 'prints the board (empty example)' do
    empty_board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
    mock_board = instance_double('Board', board_state: empty_board)

    visualised_board = described_class.stringify_board(mock_board)
    expect(visualised_board).to eq VISUAL_BOARD[:no_moves]
  end

  it 'prints the board (draw example)' do
    draw_board = [['x','o','x'], ['x','o','o'], ['o','x','x']]
    mock_board = instance_double('Board', board_state: draw_board)

    visualised_board = described_class.stringify_board(mock_board)
    expect(visualised_board).to eq VISUAL_BOARD[:draw]
  end

end
