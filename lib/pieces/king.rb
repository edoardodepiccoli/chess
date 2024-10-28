require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @unicode = '♔'
  end
end