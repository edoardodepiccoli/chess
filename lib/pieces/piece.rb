class Piece
	attr_reader :color, :unicode

	def initialize(color)
		@color = color
		@unicode = "\u265A"
	end

	def available_moves(current_position, board)
		[]
	end
end