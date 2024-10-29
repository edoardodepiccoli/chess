module BoardPrinter
  def print_board
    print "   0  1  2  3  4  5  6  7\n"
    @board.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each_with_index do |_cell, col_index|
        print_cell([row_index, col_index])
      end
      print " #{row_index}\n"
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
    bg_color = pos.sum.even? ? :red : :black
    print '   '.colorize(background: bg_color)
  end

  def print_piece_at(pos)
    piece = cell_at(pos)

    unicode = piece.unicode
    color = piece.color

    bg_color = pos.sum.even? ? :red : :black
    print " #{unicode} ".colorize(color).colorize(background: bg_color)
  end
end