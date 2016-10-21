require 'board'

describe Board, '#print_status' do

  it 'prints the board (empty example)' do
    board = described_class.new

    expect(board.print_status).to eq "
  1 | 2 | 3 
  ----------
A   |   |   
  ----------
B   |   |   
  ----------
C   |   |   "
  end

end
