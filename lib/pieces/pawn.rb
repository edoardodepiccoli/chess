require_relative "piece"

class Pawn < Piece
	attr_reader :unicode

	def initialize(color = "white")
		super(color)
		@name = "pawn"
		@unicode = ["\u2659", "\u265F"]
	end

	# copied and pasted this function from chatgpt
	# also to the king and knight and just realized
	# it is a mess, it inverted the x and y
	def possible_moves(current_index)
		x = current_index / 8 # should be y
		y = current_index % 8 # should be x and 8 - value or smth

		pawn_moves = [
			[-2, 0], [-1, 0]
		]

		valid_moves = []

		pawn_moves.each do |move|
	    new_x = x + move[0]
	    new_y = y + move[1]

	    if new_x.between?(0, 7) && new_y.between?(0, 7)
	      valid_moves << (new_x * 8 + new_y)
	    end
  	end

  	valid_moves.sort
	end
end