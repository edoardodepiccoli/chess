require_relative "piece"

class Rook < Piece
	def initialize(color = "white")
		super(color)
		@name = "rook"
	end
end