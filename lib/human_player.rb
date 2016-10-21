class HumanPlayer

  def initialize(arguments)
    @name = arguments[:name] 
    @input = arguments[:input]
  end

  def next_move
    input.gets.chomp
  end

  attr_reader :name

  private

  attr_reader :input

end
