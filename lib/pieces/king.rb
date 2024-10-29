require_relative 'piece'

class King < Piece
  attr_accessor :not_moved_yet

  def initialize(color)
    super(color)
    @unicode = '♔'

    @not_moved_yet = true
  end

  def available_positions(current_pos, board)
    current_row, current_col = current_pos

    steps = [
      [1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]
    ]

    basic_moves = steps
      .map { |step_row_offset, step_col_offset| [current_row + step_row_offset, current_col + step_col_offset] }
      .filter { |row, col| row.between?(0, 7) && col.between?(0, 7) }
      .filter { |pos| board.cell_at(pos).nil? || board.cell_at(pos).color != @color }
      .sort

    (basic_moves + castling_moves(current_pos, board)).sort
  end

  def castling_moves(current_pos, board)
    return [] unless @not_moved_yet

    right_traversing_pos = current_pos
    left_traversing_pos = current_pos

    can_go_right = false
    can_go_left = false

    0.upto(4) do
      break unless (right_traversing_pos[1] + 1).between?(0, 7)

      right_traversing_pos = [right_traversing_pos[0], right_traversing_pos[1] + 1]
      break unless board.cell_at(right_traversing_pos).nil?
    end

    if !board.cell_empty?(right_traversing_pos) &&
       board.cell_at(right_traversing_pos).is_a?(Rook) &&
       board.cell_at(right_traversing_pos).color == @color &&
       board.cell_at(right_traversing_pos).not_moved_yet

      can_go_right = true
    end

    0.upto(4) do
      break unless (left_traversing_pos[1] - 1).between?(0, 7)

      left_traversing_pos = [left_traversing_pos[0], left_traversing_pos[1] - 1]
      break unless board.cell_at(left_traversing_pos).nil?
    end

    if !board.cell_empty?(left_traversing_pos) &&
       board.cell_at(left_traversing_pos).is_a?(Rook) &&
       board.cell_at(left_traversing_pos).color == @color &&
       board.cell_at(left_traversing_pos).not_moved_yet

      can_go_left = true
    end

    available_moves = []
    available_moves << right_traversing_pos if can_go_right
    available_moves << left_traversing_pos if can_go_left

    available_moves
  end
end