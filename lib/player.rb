class Player
  def initialize(color)
    @color = color
  end

  def move
    print 'enter your move: '
    player_input = gets.chomp

    until input_valid?(player_input)
      print 'please enter a valid input: '
      player_input = gets.chomp
    end
  end

  private

  def input_valid?(input)
    input.match?(/^[0-7]{2} [0-7]{2}$/)
  end
end
