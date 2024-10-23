require_relative "piece"

class Knight < Piece
	attr_reader :unicode

	def initialize(color = "white")
		super(color)
		@name = "knight"
		@unicode = ["\u2658", "\u265E"]
	end

	def possible_moves(current_index)
		x = current_index / 8
		y = current_index % 8

		knight_moves = [
			[-2, -1], [-2, 1], [2, -1], [2, 1],
			[-1, -2], [-1, 2], [1, -2], [1, 2]
		]

		valid_moves = []

		knight_moves.each do |move|
	    new_x = x + move[0]
	    new_y = y + move[1]

	    if new_x.between?(0, 7) && new_y.between?(0, 7)
	      valid_moves << (new_x * 8 + new_y)
	    end
  	end

  	valid_moves.sort
	end
end