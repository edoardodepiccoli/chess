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

	attr_reader :board

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

	def handle_move(player, move)
		make_move(move) if move_valid?(player, move)
	end

	def cell_empty?(position)
		x, y = position
		@board[y][x].nil?
	end

	def piece_at(position)
		x, y = position
		@board[y][x]
	end

	private

	def move_valid?(player, move)

		return false if selected_empty_cell?(move)
		return false unless selected_right_color?(player, move)
		return false unless move_is_available?(player, move)

		true
	end

	def move_is_available?(player, move)
		start_position, end_position = ChessHelper.parse_algebraic_move(move)

		unless piece_at(start_position).available_moves(start_position, self).include?(end_position)
			print "that piee cannot go there, try again: "
			return false
		end

		true
	end

	def selected_empty_cell?(move)
		start_position, end_position = ChessHelper.parse_algebraic_move(move)

		if cell_empty?(start_position)
			print "cell empty, try again: "
			return true
		end

		false
	end

	def selected_right_color?(player, move)
		start_position, end_position = ChessHelper.parse_algebraic_move(move)

		if piece_at(start_position).color != player.color
			print "that piece is not yours, try again: "
			return false
		end

		true
	end

	def make_move(move)
		start_position, end_position = ChessHelper.parse_algebraic_move(move)
		place_piece(piece_at(start_position), end_position)
		empty_cell(start_position)
	end

	# utilities to print the board
	def print_cell_at(position)
		cell_color = (position.sum).even? ? :none : :red

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
	# end utilities to print the board

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

	def empty_cell(position)
		x, y = position
		@board[y][x] = nil
	end

	def clear_board
		@board = Array.new(8) { Array.new(8) }
	end
end







