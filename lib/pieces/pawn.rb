require_relative 'piece'

class Pawn < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2659", "\u265F"]
	end
end