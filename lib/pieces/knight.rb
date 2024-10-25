require_relative 'piece'

class Knight < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2658", "\u265E"]
	end

	def possible_moves(start_row, start_col, player_color, board)
		puts "validating knight available moves"
		return [
			[start_row - 2, start_col - 1], [start_row - 2, start_col + 1],
			[start_row + 2, start_col - 1], [start_row + 2, start_col + 1],
			[start_row - 1, start_col - 2], [start_row - 1, start_col + 2],
			[start_row + 1, start_col - 2], [start_row + 1, start_col + 2]
		].filter { |entry| entry[0].between?(0, 7) && entry[1].between?(0, 7) }
	end
end