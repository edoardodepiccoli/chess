require_relative 'piece'

class Pawn < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2659", "\u265F"]

		@has_not_moved_yet = true
	end

	def possible_moves(start_row, start_col, player_color, board)
		move_direction = player_color == :white ? -1 : 1

		if @has_not_moved_yet
			@has_not_moved_yet = false
			return [
				[start_row + move_direction, start_col], [start_row + move_direction * 2, start_col],
			].filter { |entry| entry[0].between?(0, 7) && entry[1].between?(0, 7) }
		else
			return [
				[start_row + move_direction, start_col]
			].filter { |entry| entry[0].between?(0, 7) && entry[1].between?(0, 7) }
		end
	end
end