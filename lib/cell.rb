class Cell

  attr_reader :row, :column
  attr_accessor :flag
  
  def initialize(arguments)
    @row = arguments[:row]
    @column = arguments[:column]
    @flag = nil
  end

end
