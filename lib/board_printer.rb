module BoardPrinter
	def print_board
		print "   a  b  c  d  e  f  g  h \n"
		@board.each_with_index do |row, row_index|
			print "#{8 - row_index} "
			row.each_with_index do |col, col_index|
				print_cell_at(ChessHelper.parse_coordinates([row_index, col_index])) # fix this
			end
			print " #{8 - row_index}\n"
		end
		print "   a  b  c  d  e  f  g  h \n"
	end

	def print_cell_at(position)
		cell_color = (ChessHelper.parse_algebraic(position).sum).even? ? :none : :red

		print_empty_cell(position) if cell_empty?(position)
		print_piece(position) unless cell_empty?(position)
	end

	def print_empty_cell(position)
		cell_color = (position.sum).even? ? :none : :red
		print "   ".colorize(:background => cell_color)
	end

	def print_piece(position)
		cell_color = (position.sum).even? ? :none : :red
		current_piece = piece_at(position)
		print " #{current_piece.unicode} ".colorize(current_piece.color).colorize(:background => cell_color)
	end
end