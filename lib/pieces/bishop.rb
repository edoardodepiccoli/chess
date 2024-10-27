require_relative "piece"

class Bishop < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2657"
	end

		def available_moves(current_position, board)
		current_position = ChessHelper.parse_algebraic(current_position)

		steps = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
		blocked_steps = []

		available_moves = []

		radius = 1
		until radius > 8
			current_moves = []
			steps.each_with_index do |step, i|

				next if blocked_steps.include?(i)

				position_at_step = [current_position[0] + step[0] * radius, current_position[1] + step[1] * radius]

				next unless position_at_step[0].between?(0, 7) && position_at_step[1].between?(0, 7)

				if board.cell_empty?(ChessHelper.parse_coordinates(position_at_step))
					available_moves.push(position_at_step)
				elsif !board.cell_empty?(ChessHelper.parse_coordinates(position_at_step)) && board.piece_at(ChessHelper.parse_coordinates(position_at_step)).color == @color
					blocked_steps.push(i)
				elsif !board.cell_empty?(ChessHelper.parse_coordinates(position_at_step)) && board.piece_at(ChessHelper.parse_coordinates(position_at_step)).color != @color
					available_moves.push(position_at_step)
					blocked_steps.push(i)
				end
			end

			radius += 1
		end

		available_moves = available_moves
		.map { |position| ChessHelper.parse_coordinates(position) }
		.sort
	end
end