class Player
  attr_accessor :loss_count, :name

  def initialize(name)
    @name = name
    @loss_count = 0
  end

  def get_move
    p "Please enter a letter"
    move = gets.chomp!
  end

  def print_loss
    ghost = "GHOST"
    puts "#{@name}: #{ghost[0...@loss_count]}"
  end
end
