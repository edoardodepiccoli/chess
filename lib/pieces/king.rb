require_relative "piece"

class King < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2654"
	end
end