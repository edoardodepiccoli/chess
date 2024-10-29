require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @unicode = '♔'
  end

  def available_positions(current_pos, board)
    current_row, current_col = current_pos

    steps = [
      [1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]
    ]

    steps
      .map { |step_row_offset, step_col_offset| [current_row + step_row_offset, current_col + step_col_offset] }
      .filter { |row, col| row.between?(0, 7) && col.between?(0, 7) }
      .filter { |pos| board.cell_at(pos).nil? || board.cell_at(pos).color != @color }
      .sort
  end
end