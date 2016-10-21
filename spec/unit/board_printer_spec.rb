describe BoardPrinter do

  it 'prints the board (empty example)' do
    mock_board = instance_double('Board', board_state: [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]])
    visualised_board = described_class.stringify_board(mock_board)

    expect(visualised_board).to eq VISUAL_BOARD[:no_moves]
  end

end
