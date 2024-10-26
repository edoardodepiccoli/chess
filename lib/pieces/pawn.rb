require_relative "piece"

class Pawn < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2659"
	end

	def available_moves(current_position, board)
		starting_col = @color == :white ? 6 : 1
		has_not_moved_yet = ChessHelper.parse_algebraic(current_position)[0] == starting_col ? true : false
	end
end