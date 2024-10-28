require_relative 'piece'

class King < Piece
  attr_accessor :has_not_moved_yet
  def initialize(color)
    super(color)
    @unicode = "\u2654"

    @has_not_moved_yet = true
  end

  def available_moves(current_position, board)
    current_position = ChessHelper.parse_algebraic(current_position)

    steps = [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]]

    available_moves = steps
      .map { |step| [current_position[0] + step[0], current_position[1] + step[1]] }
      .filter { |position| position[0].between?(0, 7) && position[1].between?(0, 7) }
      .filter { |position| board.cell_empty?(ChessHelper.parse_coordinates(position)) || board.piece_at(ChessHelper.parse_coordinates(position)).color != @color }
      .map { |position| ChessHelper.parse_coordinates(position) }
      .sort

    (available_moves + castling_moves(current_position, board)).sort
  end

  def castling_moves(current_position, board)

    right_traversing_position = current_position
    left_traversing_position = current_position

    can_go_right = false
    can_go_left = false

    0.upto(4) do
      break unless (right_traversing_position[1] + 1).between?(0, 7)
      right_traversing_position = [right_traversing_position[0], right_traversing_position[1] + 1]
      break unless board.piece_at(ChessHelper.parse_coordinates([right_traversing_position[0], right_traversing_position[1]])).nil?
    end

    if board.piece_at(ChessHelper.parse_coordinates(right_traversing_position)).is_a?(Rook) &&
       board.piece_at(ChessHelper.parse_coordinates(right_traversing_position)).color == @color &&
       board.piece_at(ChessHelper.parse_coordinates(right_traversing_position)).has_not_moved_yet

      can_go_right = true
    end

    0.upto(4) do
      break unless (left_traversing_position[1] - 1).between?(0, 7)
      left_traversing_position = [left_traversing_position[0], left_traversing_position[1] - 1]
      break unless board.piece_at(ChessHelper.parse_coordinates([left_traversing_position[0], left_traversing_position[1]])).nil?
    end

    if board.piece_at(ChessHelper.parse_coordinates(left_traversing_position)).is_a?(Rook) &&
       board.piece_at(ChessHelper.parse_coordinates(left_traversing_position)).color == @color &&
       board.piece_at(ChessHelper.parse_coordinates(left_traversing_position)).has_not_moved_yet

      can_go_left = true
    end

    available_moves = []
    available_moves << ChessHelper.parse_coordinates(right_traversing_position) if can_go_right
    available_moves << ChessHelper.parse_coordinates(left_traversing_position) if can_go_left

    return available_moves if has_not_moved_yet

    available_moves
  end
end
