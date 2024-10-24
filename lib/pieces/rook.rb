require_relative 'piece'

class Rook < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2656", "\u265C"]
	end
end