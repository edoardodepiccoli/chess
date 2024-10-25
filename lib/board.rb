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
		print("  0  1  2  3  4  5  6  7 \n")
		@board.each_with_index do |row, row_index|
			print(row_index)
			row.each_with_index do |col, col_index|
				display_cell(row_index, col_index)

				print "#{row_index}\n" if col_index == 7
			end
		end
		print("  0  1  2  3  4  5  6  7 \n")
	end

	def make_move(start_row, start_col, end_row, end_col)
		move_piece(start_row, start_col, end_row, end_col)
	end

	def move_valid?(start_row, start_col, end_row, end_col, player_color)
		return false unless starting_position_valid?(start_row, start_col, player_color)
		return false unless ending_position_valid?(end_row, end_col, player_color)
		return false unless move_possible?(piece_at(start_row, start_col), start_row, start_col, end_row, end_col, player_color)

		true
	end

	def piece_at(row, col)
		@board.dig(row, col)
	end

	private

	def move_possible?(piece, start_row, start_col, end_row, end_col, player_color)
		unless piece.possible_moves(start_row, start_col, player_color, self).include?([end_row, end_col])
			puts "piece cannot move there"
			return false
		end

		true
	end

	def starting_position_valid?(row, col, player_color)
		if cell_empty?(row, col)
			puts "you selected an empty cell, retry"
			return false
		elsif piece_at(row, col).color != player_color
			puts "that piece is not yours"
			return false
		else
			return true
		end
	end

	def ending_position_valid?(end_row, end_col, player_color)
		if !piece_at(end_row, end_col).nil? && piece_at(end_row, end_col).color == player_color
			puts "looks like you want to eat your own piece, duh. retry"
			return false
		else
			return true
		end
	end

	def move_piece(start_row, start_col, end_row, end_col)
		piece = piece_at(start_row, start_col)
		@board[end_row][end_col] = piece
		@board[start_row][start_col] = nil
	end

	def display_cell(row, col)
		if cell_empty?(row, col)
			display_empty_cell(row, col) 
		else
			display_piece(row, col)
		end
	end

	def display_piece(row, col)
		piece_to_display = piece_at(row, col)

		print " #{piece_to_display.unicode[0]} ".colorize(:background => cell_color(row, col)) if piece_to_display.color == :white
		print " #{piece_to_display.unicode[1]} ".colorize(:background => cell_color(row, col)) if piece_to_display.color == :black
	end

	def display_empty_cell(row, col)
		print '   '.colorize(:background => cell_color(row, col))
	end

	def cell_empty?(row, col)
		true if @board[row][col].nil?
	end

	def cell_color(row, col)
		return :red if (row + col).odd?
		return :white if (row + col).even?
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