require_relative 'piece'

class Queen < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2655", "\u265B"]
	end
end