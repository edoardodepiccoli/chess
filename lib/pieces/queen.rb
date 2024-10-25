require_relative "piece"

class Queen < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2655"
	end
end