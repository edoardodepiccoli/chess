require_relative 'piece'

class Rook < Piece
  attr_accessor :not_moved_yet

  def initialize(color)
    super(color)
    @unicode = '♖'

    @not_moved_yet = true
  end

  def available_positions(current_pos, board)
    current_row, current_col = current_pos

    steps = [
      [1, 0], [0, 1], [0, -1], [-1, 0]
    ]

    all_available_positions = []

    steps.each do |step_row_offset, step_col_offset|
      1.upto(7) do |i|
        next_position = [current_row + (step_row_offset * i), current_col + (step_col_offset * i)]
        break unless next_position[0].between?(0, 7) && next_position[1].between?(0, 7)

        if board.cell_at(next_position).nil?
          all_available_positions << next_position
        elsif board.cell_at(next_position).color != @color
          all_available_positions << next_position
          break
        else
          break
        end
      end
    end

    all_available_positions.sort
  end
end