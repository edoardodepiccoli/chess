require "colorize"

require_relative "chess_helper"
require_relative "player"

require_relative "pieces/piece"

class Board
	include ChessHelper

	def initialize
		@board = Array.new(8) { Array.new(8) }
		@board[0][1] = Piece.new(:black)
	end

	def print_board
		print "   a  b  c  d  e  f  g  h \n"
		@board.each_with_index do |row, row_index|
			print "#{row_index} "
			row.each_with_index do |col, col_index|
				print_cell_at([col_index, row_index]) # x is col, y is row
			end
			print " #{row_index}\n"
		end
		print "   a  b  c  d  e  f  g  h \n"
	end

	private

	# helper methods to print the board
	def print_cell_at(position)
		x, y = position
		cell_color = (x + y).even? ? :white : :red

		print_empty_cell([x, y]) if cell_empty?([x, y])
		print_piece([x, y]) unless cell_empty?([x, y])
	end

	def print_empty_cell(position)
		x, y = position
		cell_color = (x + y).even? ? :white : :red
		print "   ".colorize(:background => cell_color)
	end

	def print_piece(position)
		x, y = position
		cell_color = (x + y).even? ? :white : :red
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
	# end helper methods to print the board
end