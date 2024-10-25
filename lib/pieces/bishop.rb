require_relative "piece"

class Bishop < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2657"
	end
end