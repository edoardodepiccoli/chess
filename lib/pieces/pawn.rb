require_relative "piece"

class Pawn < Piece
	def initialize(color)
		super(color)
		@unicode = "\u2659"
	end

	def available_moves(current_position, board)
		current_position = ChessHelper.parse_algebraic(current_position)

		has_not_moved_yet = in_starting_row?(current_position)
		row_move_direction = @color == :white ? -1 : 1

		steps = has_not_moved_yet ? [[row_move_direction, 0], [row_move_direction * 2, 0]] : [[row_move_direction, 0]]
		eating_steps = [[row_move_direction, 1], [row_move_direction, -1]]

		available_basic_moves = steps
		.map { |step| [current_position[0] + step[0], current_position[1] + step[1]] }
		.filter { |position| position[0].between?(0, 7) && position[1].between?(0, 7) }
		.filter { |position| board.cell_empty?(ChessHelper.parse_coordinates(position)) }
		.map { |position| ChessHelper.parse_coordinates(position) }
		.sort

		available_eating_moves = eating_steps
		.map { |step| [current_position[0] + step[0], current_position[1] + step[1]] }
		.filter { |position| position[0].between?(0, 7) && position[1].between?(0, 7) }
		.filter { |position| !board.cell_empty?(ChessHelper.parse_coordinates(position)) && board.piece_at(ChessHelper.parse_coordinates(position)).color != @color }
		.map { |position| ChessHelper.parse_coordinates(position) }
		.sort

		(available_basic_moves + available_eating_moves).sort
	end

	def in_starting_row?(current_position)
		starting_row = @color == :white ? 6 : 1
		current_position[0] == starting_row
	end
end





