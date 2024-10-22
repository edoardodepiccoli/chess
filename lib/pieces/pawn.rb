require_relative "piece"

class Pawn < Piece
	def initialize(color = "white")
		super(color)
		@name = "pawn"
	end
end