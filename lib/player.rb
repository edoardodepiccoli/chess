class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move
    print "player #{@color} enter your move: "
    player_input = gets.chomp

    until input_valid?(player_input)
      print 'please enter a valid input: '
      player_input = gets.chomp
    end

    start_pos, end_pos = player_input.split ' '
    start_row, start_col = start_pos.split('').map(&:to_i)
    end_row, end_col = end_pos.split('').map(&:to_i)

    [[start_row, start_col], [end_row, end_col]]
  end

  private

  def input_valid?(input)
    input.match?(/^[a-h][1-8] [a-h][1-8]$/)
  end
end
