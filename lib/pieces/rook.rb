require_relative "piece"

class Rook < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2656"
	end
end