require_relative "piece"
require_relative "../../lib/chess_helper"

class King < Piece
	attr_reader :unicode

	include ChessHelper

	def initialize(color = "white")
		super(color)
		@name = "king"
		@unicode = ["\u2654", "\u265A"]
	end

	def possible_moves(current_index)
		current_coord = index_to_coord(current_index)

		x = current_index / 8
		y = current_index % 8

		king_moves = [
			[-1, -1], [-1, 0], [-1, 1],
			[0, -1], [0, 1],
			[1, -1], [1, 0], [1, 1]
		]

		valid_moves = []

		king_moves.each do |move|
	    new_x = x + move[0]
	    new_y = y + move[1]

	    if new_x.between?(0, 7) && new_y.between?(0, 7)
	      valid_moves << (new_x * 8 + new_y)
	    end
  	end

  	valid_moves.sort
	end
end