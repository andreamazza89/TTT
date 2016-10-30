#Understands its location in a 2D board

class Cell

  attr_reader :row, :column
  attr_accessor :flag
  
  def initialize(arguments)
    @row = arguments[:row]
    @column = arguments[:column]
    @flag = nil
  end

  def ==(other)
    other.row == self.row && other.column == self.column
  end

end
