module BoardPrinter
  def print_board
    print "   a  b  c  d  e  f  g  h\n"
    @board.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      row.each_with_index do |_cell, col_index|
        print_cell([row_index, col_index])
      end
      print " #{8 - row_index}\n"
    end
    print "   a  b  c  d  e  f  g  h\n"
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
