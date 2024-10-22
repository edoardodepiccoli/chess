require_relative "piece"

class King < Piece
	include ChessHelper

	def initialize(color = "white")
		super(color)
		@name = "king"
	end

	def possible_moves(current_index)
		raw_moves = [
			current_index - 1, current_index + 1,
			current_index - 8, current_index + 8,
			current_index - 7, current_index + 7,
			current_index - 9, current_index + 9
		]

		possible_moves = raw_moves.filter |index| do
			index >= 0 && index <= 63 && index
		end
	end
end