require_relative 'piece'

class Knight < Piece
  def initialize(color)
    super(color)
    @unicode = '♘'
  end
end