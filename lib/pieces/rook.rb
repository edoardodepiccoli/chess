require_relative 'piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @unicode = '♖'
  end
end