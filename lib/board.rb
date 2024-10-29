require 'colorize'

require_relative 'board_printer'
require_relative 'pieces/piece'
require_relative 'pieces/bishop'

class Board
  include BoardPrinter

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def move_valid?(player, move)
    true
  end

  def make_move(move) # [[start_row, start_col], [end_row, end_col]]
    start_pos, end_pos = move
    piece_to_move = cell_at(start_pos)
    piece_to_eat = cell_at(end_pos)

    # move piece to destination
    place_piece(piece_to_move, end_pos)
    # clear starting cell
    clear_cell(start_pos)
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

  def clear_cell(pos)
    row, col = pos
    @board[row][col] = nil
  end

  def place_new_pieces(entries)
end