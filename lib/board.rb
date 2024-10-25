require "colorize"

require_relative "chess_helper"
require_relative "player"

require_relative "pieces/piece"
require_relative "pieces/pawn"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"


class Board
	include ChessHelper

	def initialize
		@board = Array.new(8) { Array.new(8) }

		initialize_board
	end

	def print_board
		print "   a  b  c  d  e  f  g  h \n"
		@board.each_with_index do |row, row_index|
			print "#{8 - row_index} "
			row.each_with_index do |col, col_index|
				print_cell_at([col_index, row_index]) # x is col, y is row
			end
			print " #{8 - row_index}\n"
		end
		print "   a  b  c  d  e  f  g  h \n"
	end

	private

	def print_cell_at(position)
		x, y = position
		cell_color = (x + y).even? ? :none : :red

		print_empty_cell([x, y]) if cell_empty?([x, y])
		print_piece([x, y]) unless cell_empty?([x, y])
	end

	def print_empty_cell(position)
		x, y = position
		cell_color = (x + y).even? ? :none : :red
		print "   ".colorize(:background => cell_color)
	end

	def print_piece(position)
		x, y = position
		cell_color = (x + y).even? ? :none : :red
		current_piece = piece_at([x, y])
		print " #{current_piece.unicode} ".colorize(current_piece.color).colorize(:background => cell_color)
	end

	def piece_at(position)
		x, y = position
		@board[y][x]
	end

	def cell_empty?(position)
		x, y = position
		@board[y][x].nil?
	end

	def initialize_board
		place_new_pieces([
			[Pawn, :black, ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]],
			[Pawn, :white, ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]],
			[Rook, :black, ["a8", "h8"]],
			[Rook, :white, ["a1", "h1"]],
			[Knight, :black, ["b8", "g8"]],
			[Knight, :white, ["b1", "g1"]],
			[Bishop, :black, ["c8", "f8"]],
			[Bishop, :white, ["c1", "f1"]],
			[King, :black, ["e8"]],
			[King, :white, ["e1"]],
			[Queen, :black, ["d8"]],
			[Queen, :white, ["d1"]]
		])
	end

	def place_new_pieces(entries)
		entries.each do |entry|
			entry[2].each do |position|
				position = ChessHelper.parse_algebraic(position)
				place_piece(entry[0].new(entry[1]), position)
			end
		end
	end

	def place_piece(piece, position)
		x, y = position
		@board[y][x] = piece
	end
end







