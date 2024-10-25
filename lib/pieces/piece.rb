class Piece
	attr_reader :color, :unicode

	def initialize(color)
		@color = color
		@unicode = "\u265A"
	end
end