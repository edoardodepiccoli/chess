require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @unicode = '♙'
  end

  def available_positions(current_pos, board)
    current_row, current_col = current_pos
    row_offset = @color == :white ? -1 : 1

    steps = if not_moved_yet?(current_pos)
              [[row_offset, 0], [row_offset * 2, 0]]
            else
              [[row_offset, 0]]
            end

    steps
      .map { |row_offset, _col_offset| [current_row + row_offset, current_col] }
      .filter { |row, col| row.between?(0, 7) && col.between?(0, 7) }
      .filter { |pos| board.cell_at(pos).nil? }
  end

  def not_moved_yet?(current_pos)
    current_row, _current_col = current_pos
    starting_row = @color == :white ? 6 : 1

    current_row == starting_row
  end
end