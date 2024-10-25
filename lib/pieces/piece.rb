class Piece
	attr_reader :color
	
	def initialize(color)
		@color = color
	end

	def possible_moves(start_row, start_col, player_color, board)
		puts "move not available for this piece (piece class)"
		return []
	end
end