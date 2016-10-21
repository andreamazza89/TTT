class HumanPlayer

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
    @flag = arguments[:flag]
  end

  def next_move
    input.gets.chomp
  end

  attr_reader :name, :flag

  private

  attr_reader :input

end
