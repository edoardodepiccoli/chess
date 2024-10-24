require_relative 'piece'

class Knight < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2658", "\u265E"]
	end
end