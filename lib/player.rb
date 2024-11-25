class Player
  attr_reader :color

  def letter_to_col(letter)
    mappings = {
      0 => 'a',
      1 => 'b',
      2 => 'c',
      3 => 'd',
      4 => 'e',
      5 => 'f',
      6 => 'g',
      7 => 'h'
    }

    reverse_mappings = mappings.invert

    reverse_mappings[letter]
  end

  def number_to_row(number)
    8 - number
  end

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

    start_col, start_row = start_pos.split('')
    start_col = letter_to_col(start_col)
    start_row = number_to_row(start_row.to_i)

    end_col, end_row = end_pos.split('')
    end_col = letter_to_col(end_col)
    end_row = number_to_row(end_row.to_i)

    [[start_row, start_col], [end_row, end_col]]
  end

  private

  def input_valid?(input)
    input.match?(/^[a-h][1-8] [a-h][1-8]$/)
  end
end
