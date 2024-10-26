require_relative "piece"

class King < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2654"
	end

	def available_moves(current_position, board)
		steps = [
		  [1, 1],
		  [1, 0],
		  [1, -1],
		  [0, 1],
		  [0, -1],
		  [-1, 1],
		  [-1, 0],
		  [-1, -1]
		]

		available_moves = steps
		.map { |step| [current_position[0] + step[0], current_position[1] + step[1]] }
		.filter { |position| position[0].between?(0, 7) && position[1].between?(0, 7) }
		.filter { |position| board.cell_empty?(position) || board.piece_at(position).color != @color}
		.sort
	end
end