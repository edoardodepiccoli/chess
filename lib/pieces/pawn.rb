require_relative "piece"

class Pawn < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2659"
	end

	def available_moves(current_position, board)
		moves = []

		current_position = ChessHelper.parse_algebraic(current_position)

		starting_col = @color == :white ? 6 : 1
		move_direction = @color == :white ? -1 : 1

		has_not_moved_yet = current_position[0] == starting_col ? true : false

		first_vertical_move = ChessHelper.parse_coordinates([current_position[0] + move_direction, current_position[1]])
		second_vertical_move = ChessHelper.parse_coordinates([current_position[0] + move_direction * 2, current_position[1]])
		eat_left_move = ChessHelper.parse_coordinates([current_position[0] + move_direction, current_position[1] - 1])
		eat_right_move = ChessHelper.parse_coordinates([current_position[0] + move_direction, current_position[1] + 1])

		if board.cell_empty?(first_vertical_move)
			moves.push(first_vertical_move)
			if board.cell_empty?(second_vertical_move) && has_not_moved_yet
				moves.push(second_vertical_move)
			end
		end

		if !board.cell_empty?(eat_left_move) && board.piece_at(eat_left_move).color != @color
			moves.push(eat_left_move)
		end

		if !board.cell_empty?(eat_right_move) && board.piece_at(eat_right_move).color != @color
			moves.push(eat_right_move)
		end

		moves.sort
	end
end