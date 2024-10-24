require_relative 'piece'

class Bishop < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2657", "\u265D"]
	end
end