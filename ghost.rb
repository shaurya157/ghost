
require_relative 'player.rb'

class Game
  def initialize(dictionary, *args)
    @dictionary = dictionary
    @players = args
    @current_player = @players[0]
    @fragment = ""
  end

  def switch_player
    index = @players.index(@current_player)
    if index == @players.length - 1
      @current_player = @players[index % (@players.length - 1)]
    else
      @current_player = @players[index + 1]
    end
  end

  def valid_play?(string)
    return false if string.match(/[a-z]/i) == nil || string.length > 1
    temp_dictionary = shorten_dictionary(string)
    if temp_dictionary.empty?
      return false
    else
      @new_dictionary = temp_dictionary
      return true
    end
  end

  def run
    puts "WELCOME TO GHOST!"
    until @players.length == 1
      play_round
      @players.delete_if {|player| player.loss_count == 5}
    end

    puts "AND THE WINNER IS... #{@current_player.name}"
  end

  def take_turn(player)
    move = player.get_move
    until valid_play?(move)
      p "Invalid play. Please try again"
      move = player.get_move
    end
    move
  end

  def play_round
    @fragment = ""
    p "Current player is: #{@current_player.name}"
    @fragment << take_turn(@current_player)
    switch_player

    until round_lose
      p "Current player is: #{@current_player.name}"
      @fragment << take_turn(@current_player)
      puts "Word so far: #{@fragment}"
      switch_player
    end

    (@players.length-1).times {switch_player} #revert back to the losing player
    @current_player.loss_count += 1
    @current_player.print_loss
  end

  def shorten_dictionary(string)
    if @fragment.length == 0
      @new_dictionary = @dictionary[string]
    else
      temp_frag = @fragment + string
      temp_dictionary = @new_dictionary.select {|n| n[0...temp_frag.length] == temp_frag }
      return temp_dictionary
    end
  end

  def round_lose
    @fragment == @new_dictionary[0] ? true : false
  end


end

if __FILE__ == $PROGRAM_NAME
  hash = {}
  File.open('dictionary.txt').each do |word|
    if hash[word[0]]
      hash[word[0]] << word.chomp!
    else
      hash[word[0]] = [word.chomp!]
    end
  end

  player1 = Player.new("Shaurya")
  player2 = Player.new("Jay")
  player3 = Player.new("Jacky")
  game = Game.new(hash, player1, player2, player3)
  game.run
end
