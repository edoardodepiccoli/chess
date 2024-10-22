require_relative "piece"

class Bishop < Piece
	def initialize(color = "white")
		super(color)
		@name = "bishop"
	end

	def possible_moves(current_index)
		initial_index = current_index
		possible_moves = []

		# go up left
		while ![0, 8, 12, 24, 32, 40, 48, 56].include?(current_index) && current_index >= 0
			current_index -= (9)
			possible_moves.push(current_index) if current_index >= 0
		end
		current_index = initial_index
		# go up right
		while ![7, 11, 23, 31, 39, 47, 55, 63].include?(current_index) && current_index >= 0
			current_index -= (7)
			possible_moves.push(current_index) if current_index >= 0
		end
		current_index = initial_index
		# go down left
		while ![0, 8, 12, 24, 32, 40, 48, 56].include?(current_index) && current_index <= 63
			current_index += (7)
			possible_moves.push(current_index) if current_index <= 63
		end
		current_index = initial_index
		# go down right
		while ![7, 11, 23, 31, 39, 47, 55, 63].include?(current_index) && current_index <= 63
			current_index += (9)
			possible_moves.push(current_index) if current_index <= 63
		end
		current_index = initial_index

		possible_moves.sort
	end
end