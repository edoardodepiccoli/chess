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
				print_cell_at(ChessHelper.parse_coordinates([row_index, col_index])) # fix this
			end
			print " #{8 - row_index}\n"
		end
		print "   a  b  c  d  e  f  g  h \n"
	end

	def cell_empty?(position)
		row, col = ChessHelper.parse_algebraic(position)
		@board[row][col].nil?
	end

	def piece_at(position)
		row, col = ChessHelper.parse_algebraic(position)
		@board[row][col]
	end

	def move_valid?(player, move)
		return false if selected_empty_cell?(move)
		return false unless selected_right_color?(player, move)
		return false unless move_is_available?(player, move)
		return false if move_leaves_king_in_danger?(player, move)

		true
	end

	def make_move(move)
		start_position, end_position = move.split(" ")

		place_piece(piece_at(start_position), end_position)
		empty_cell(start_position)
	end

	def checkmate?(player)
		color = player.color
		
		return true unless player_has_available_moves?(player)

		false
	end

	private

	def player_has_available_moves?(player)
		color = player.color

		all_available_moves = []

		@board.each_with_index do |row, row_index|
			row.each_with_index do |piece, col_index|
				next if cell_empty?(ChessHelper.parse_coordinates([row_index, col_index]))
				next if piece_at(ChessHelper.parse_coordinates([row_index, col_index])).color != color

				all_available_moves += piece_at(ChessHelper.parse_coordinates([row_index, col_index])).available_moves(ChessHelper.parse_coordinates([row_index, col_index]), self)
				.map { |end_position| "#{ChessHelper.parse_coordinates([row_index, col_index])} #{end_position}" }
			end
		end

		return false if all_available_moves.all? { |move| move_leaves_king_in_danger?(player, move) }

		true
	end

	def move_leaves_king_in_danger?(player, move)
		color = player.color

		temp = @board.map(&:dup)

		make_move(move)
		if king_in_danger?(color)
			print "move leaves the king in danger! try another one: "
			@board = temp.map(&:dup)
			return true
		end

		@board = temp.map(&:dup)
		false
	end

	def king_in_danger?(color)
		king_position = find_king(color)
		# loop through all the opponent's pieces and find if there is one that
		# has the king's position inside its available moves
		@board.each_with_index do |row, row_index|
			row.each_with_index do |piece, col_index|
				next if cell_empty?(ChessHelper.parse_coordinates([row_index, col_index]))
				next if piece_at(ChessHelper.parse_coordinates([row_index, col_index])).color == color

				available_moves = piece_at(ChessHelper.parse_coordinates([row_index, col_index])).available_moves(ChessHelper.parse_coordinates([row_index, col_index]), self)
				return true if available_moves.include?(king_position)
			end
		end

		false
	end

	def find_king(color)
		@board.each_with_index do |row, row_index|
			row.each_with_index do |piece, col_index|
				if piece.is_a?(Piece)
					return ChessHelper.parse_coordinates([row_index, col_index]) if piece.is_a?(King) && piece.color == color
				end
			end
		end
	end

	def move_is_available?(player, move)
		start_position, end_position = move.split(" ")

		unless piece_at(start_position).available_moves(start_position, self).include?(end_position)
			print "that piece cannot go there, try again: "
			return false
		end

		true
	end

	def selected_empty_cell?(move)
		start_position, end_position = move.split(" ")

		if cell_empty?(start_position)
			print "cell empty, try again: "
			return true
		end

		false
	end

	def selected_right_color?(player, move)
		start_position, end_position = move.split(" ")

		if piece_at(start_position).color != player.color
			print "that piece is not yours, try again: "
			return false
		end

		true
	end

	# utilities to print the board
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
				place_piece(entry[0].new(entry[1]), position)
			end
		end
	end

	def place_piece(piece, position)
		row, col = ChessHelper.parse_algebraic(position)
		@board[row][col] = piece
	end

	def empty_cell(position)
		row, col = ChessHelper.parse_algebraic(position)
		@board[row][col] = nil
	end

	def clear_board
		@board = Array.new(8) { Array.new(8) }
	end
end







