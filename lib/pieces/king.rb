require_relative 'piece'

class King < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2654", "\u265A"]
	end

	def possible_moves(start_row, start_col, player_color, board)
		puts "validating king available moves"
		return [
			[start_row - 1, start_col - 1], [start_row - 1, start_col], [start_row - 1, start_col + 1],
			[start_row, start_col - 1], [start_row, start_col + 1],
			[start_row + 1, start_col - 1], [start_row + 1, start_col], [start_row + 1, start_col + 1]
		].filter { |entry| entry[0].between?(0, 7) && entry[1].between?(0, 7) }
	end
end