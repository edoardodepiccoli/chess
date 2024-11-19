module BoardPrinter
  @mappings = {
    0 => 'a',
    1 => 'b',
    2 => 'c',
    3 => 'd',
    4 => 'e',
    5 => 'f',
    6 => 'g',
    7 => 'h'
  }

  def self.mappings
    @mappings
  end

  def print_board
    print "   0  1  2  3  4  5  6  7\n"
    @board.each_with_index do |row, row_index|
      print "#{BoardPrinter.mappings[7 - row_index]} "
      row.each_with_index do |_cell, col_index|
        print_cell([row_index, col_index])
      end
      print " #{BoardPrinter.mappings[7 - row_index]}\n"
    end
    print "   0  1  2  3  4  5  6  7\n"
  end

  def print_cell(pos)
    if cell_empty?(pos)
      print_empty_cell(pos)
    else
      print_piece_at(pos)
    end
  end

  def print_empty_cell(pos)
    bg_color = pos.sum.even? ? :red : :none
    print '   '.colorize(background: bg_color)
  end

  def print_piece_at(pos)
    piece = cell_at(pos)

    unicode = piece.unicode
    color = piece.color

    bg_color = pos.sum.even? ? :red : :none
    print " #{unicode} ".colorize(color).colorize(background: bg_color)
  end
end
