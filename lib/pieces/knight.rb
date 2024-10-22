require_relative "piece"

class Knight < Piece
	def initialize(color = "white")
		super(color)
		@name = "knight"
	end
end