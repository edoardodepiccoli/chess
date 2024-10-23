require_relative "piece"

class Queen < Piece
	attr_reader :unicode

	def initialize(color = "white")
		super(color)
		@name = "queen"
		@unicode = ["\u2655", "\u265B"]
	end

	def possible_moves(current_index)
		x = current_index % 8 # from left to right
		y = current_index / 8 # from top to bottom

		all_moves = []

		# depth first search-like moves population, let's try
		radius = 1
		while radius < 9 
			# up left
			# up 
			# up right
			# left
			# right
			# down left
			# down
			# down right
			moves_in_radius = [
				[-radius, -radius], [0, -radius], [radius, -radius],
				[-radius, 0], [radius, 0],
				[-radius, radius], [0, radius], [radius, radius]
			]

			all_moves += moves_in_radius
			radius += 1
		end

		valid_moves = []

		all_moves.each do |move|
	    new_x = x + move[0]
	    new_y = y + move[1]

	    if new_x.between?(0, 7) && new_y.between?(0, 7)
	      valid_moves << (new_y * 8 + new_x)
	    end
  	end

  	valid_moves.sort
	end
end