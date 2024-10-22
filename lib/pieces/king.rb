require_relative "piece"

class King < Piece
	def initialize(color = "white")
		super(color)
		@name = "king"
	end
end