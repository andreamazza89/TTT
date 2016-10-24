describe Cell, '#row' do

  it 'returns the cells row' do
    cell = described_class.new(row: 2)
    
    expect(cell.row).to eq 2 
  end

end

describe Cell, '#column' do

  it 'returns the cells column' do
    cell = described_class.new(column: 0)
    
    expect(cell.column).to eq 0 
  end

end

describe Cell, '#flag' do

  it 'sets and returns the cells flag' do
    cell = described_class.new(column: 0, row: 0)
    cell.flag = 'x'
    
    expect(cell.flag).to eq 'x' 
  end

  it 'defaults to nil' do
    cell = described_class.new(column: 0)
    
    expect(cell.flag).to eq nil 
  end

end
