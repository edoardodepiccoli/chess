class Piece
  attr_reader :color, :unicode

  def initialize(color)
    @color = color
  end

  def available_positions(current_pos, board)
    []
  end
end