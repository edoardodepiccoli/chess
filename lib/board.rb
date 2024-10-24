require 'colorize'

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'


class Board
	def initialize
		@board = Array.new(8) { Array.new(8) }

		initialize_pieces
	end

	def display_board
		@board.each_with_index do |row, row_index|
			row.each_with_index do |col, col_index|
				display_cell(row_index, col_index)

				print "\n" if col_index == 7
			end
		end
	end

	private

	def display_cell(row_index, col_index)
		if cell_empty?(row_index, col_index)
			display_empty_cell(row_index, col_index) 
		else
			piece_to_display = @board[row_index][col_index]
			display_piece(piece_to_display, row_index, col_index)
		end
	end

	def display_piece(piece_to_display, row_index, col_index)
		print " #{piece_to_display.unicode[0]} ".colorize(:background => cell_color(row_index, col_index)) if piece_to_display.color == :white
		print " #{piece_to_display.unicode[1]} ".colorize(:background => cell_color(row_index, col_index)) if piece_to_display.color == :black
	end

	def display_empty_cell(row_index, col_index)
		print '   '.colorize(:background => cell_color(row_index, col_index))
	end

	def cell_empty?(row_index, col_index)
		true if @board[row_index][col_index].nil?
	end

	def cell_color(row_index, col_index)
		return :red if (row_index + col_index).odd?
		return :white if (row_index + col_index).even?
	end

	def initialize_pieces
		# initialize black pieces
		@board[0][0] = Rook.new(:black)
		@board[0][1] = Knight.new(:black)
		@board[0][2] = Bishop.new(:black)
		@board[0][3] = Queen.new(:black)
		@board[0][4] = King.new(:black)
		@board[0][5] = Bishop.new(:black)
		@board[0][6] = Knight.new(:black)
		@board[0][7] = Rook.new(:black)

		@board[1][0] = Pawn.new(:black)
		@board[1][1] = Pawn.new(:black)
		@board[1][2] = Pawn.new(:black)
		@board[1][3] = Pawn.new(:black)
		@board[1][4] = Pawn.new(:black)
		@board[1][5] = Pawn.new(:black)
		@board[1][6] = Pawn.new(:black)
		@board[1][7] = Pawn.new(:black)

		#initialize white pieces
		@board[7][0] = Rook.new(:white)
		@board[7][1] = Knight.new(:white)
		@board[7][2] = Bishop.new(:white)
		@board[7][3] = Queen.new(:white)
		@board[7][4] = King.new(:white)
		@board[7][5] = Bishop.new(:white)
		@board[7][6] = Knight.new(:white)
		@board[7][7] = Rook.new(:white)

		@board[6][0] = Pawn.new(:white)
		@board[6][1] = Pawn.new(:white)
		@board[6][2] = Pawn.new(:white)
		@board[6][3] = Pawn.new(:white)
		@board[6][4] = Pawn.new(:white)
		@board[6][5] = Pawn.new(:white)
		@board[6][6] = Pawn.new(:white)
		@board[6][7] = Pawn.new(:white)
	end
end