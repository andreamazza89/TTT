require 'board'
require_relative '../fixtures/stringified_boards'

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

    expect(board.stringified_status).to eq BOARDS_AS_STRINGS[:one_move]
  end

end
