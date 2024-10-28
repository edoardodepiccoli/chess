require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @unicode = '♙'
  end
end