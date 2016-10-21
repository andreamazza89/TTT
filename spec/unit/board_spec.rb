require 'board'
require_relative '../fixtures/stringified_boards'

describe Board, '#print_status' do

  it 'prints the board (empty example)' do
    board = described_class.new

    expect(board.print_status).to eq BOARDS_AS_STRINGS[:empty_board]
  end

end
