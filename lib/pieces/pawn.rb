require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @unicode = '♙'
  end

  def available_positions(current_pos, board)
    current_row, current_col = current_pos
    row_offset = @color == :white ? -1 : 1

    vertical_steps = if not_moved_yet?(current_pos)
                       [[row_offset, 0], [row_offset * 2, 0]]
                     else
                       [[row_offset, 0]]
                     end

    available_vertical_positions = vertical_steps
                              .map { |step_row_offset, _step_col_offset| [current_row + step_row_offset, current_col] }
                              .filter { |row, col| row.between?(0, 7) && col.between?(0, 7) }
                              .filter { |pos| board.cell_at(pos).nil? }
                              .sort

    eating_steps = [[row_offset, 1], [row_offset, -1]]

    available_eating_position = eating_steps
                               .map { |step_row_offset, step_col_offset| [current_row + step_row_offset, current_col + step_col_offset] }
                               .filter { |row, col| row.between?(0, 7) && col.between?(0, 7) }
                               .filter { |pos| !board.cell_at(pos).nil? && board.cell_at(pos).color != @color }

    (available_vertical_positions + available_eating_position).sort
  end

  def not_moved_yet?(current_pos)
    current_row, _current_col = current_pos
    starting_row = @color == :white ? 6 : 1

    current_row == starting_row
  end
end