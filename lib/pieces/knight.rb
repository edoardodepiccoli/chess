require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @unicode = "\u2658"
  end

  def available_moves(current_position, board)
    current_position = ChessHelper.parse_algebraic(current_position)

    steps = [[-2, 1], [-2, -1], [2, 1], [2, -1], [-1, 2], [-1, -2], [1, 2], [1, -2]]

    available_moves = steps
                      .map { |step| [current_position[0] + step[0], current_position[1] + step[1]] }
                      .filter { |position| position[0].between?(0, 7) && position[1].between?(0, 7) }
                      .filter { |position| board.cell_empty?(ChessHelper.parse_coordinates(position)) || board.piece_at(ChessHelper.parse_coordinates(position)).color != @color }
                      .map { |position| ChessHelper.parse_coordinates(position) }
                      .sort
  end
end
