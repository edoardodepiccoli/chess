require_relative "piece"

class Queen < Piece
	def initialize(color = "white")
		super(color)
		@name = "queen"
	end
end