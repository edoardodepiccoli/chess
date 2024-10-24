require_relative 'piece'

class King < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2654", "\u265A"]
	end
end