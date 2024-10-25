require_relative 'piece'

class Rook < Piece
	attr_reader :unicode
	
	def initialize(color)
		super(color)
		@unicode = ["\u2656", "\u265C"]
	end

	def possible_moves(start_row, start_col, player_color, board)
		puts "validating rook available moves"

		possible_moves = []

		steps = [
			[-1, 0], [0, -1], [0, +1], [+1, 0]
		] # order is very important here
		occupied_directions = [] # holds indexes of denied steps

		radius = 1

		while radius < 8
			steps.each_with_index do |step, index|

				if occupied_directions.include?(index)
					next
				end

				next_position = [start_row + (radius * step[0]), start_col + (radius * step[1])]
				piece_on_next_position = board.piece_at(next_position[0], next_position[1])

				if !piece_on_next_position.nil? && piece_on_next_position.color != player_color
					possible_moves.push(next_position)
					occupied_directions.push(index)
					next
				elsif !piece_on_next_position.nil? && piece_on_next_position.color == player_color
					occupied_directions.push(index)
					next
				else
					possible_moves.push(next_position)
				end
			end

			radius += 1
		end
		
		return possible_moves
	end
end