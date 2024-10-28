require 'colorize'

require_relative 'board_printer'
require_relative 'pieces/piece'
require_relative 'pieces/bishop'

class Board
  include BoardPrinter

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def cell_at(pos)
    row, col = pos
    @board[row][col]
  end

  def cell_empty(pos)
    cell_at(pos).nil?
  end

  def place_piece(piece, pos)
    row, col = pos
    @board[row][col] = piece
  end
end