require 'colorize'

require_relative 'board_printer'

require_relative 'pieces/piece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board
  include BoardPrinter

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }

    place_new_pieces(
      [
        [Pawn, :black, [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]],
        [Rook, :black, [[0, 0], [0,  7]]],
        [Knight, :black, [[0, 1], [0,  6]]],
        [Bishop, :black, [[0, 2], [0,  5]]],
        [Queen, :black, [[0, 3]]],
        [King, :black, [[0, 4]]],
        [Pawn, :white, [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]]],
        [Rook, :white, [[7, 0], [7,  7]]],
        [Knight, :white, [[7, 1], [7,  6]]],
        [Bishop, :white, [[7, 2], [7,  5]]],
        [Queen, :white, [[7, 3]]],
        [King, :white, [[7, 4]]],
      ]
    )

    @pieces_eaten = []
    @moves_history = []
  end

  # [[start_row, start_col], [end_row, end_col]]
  def make_move(move)
    start_pos, end_pos = move

    piece_to_move = cell_at(start_pos)
    piece_to_eat = cell_at(end_pos)

    place_piece(piece_to_move, end_pos)
    clear_cell(start_pos)

    @pieces_eaten << piece_to_eat unless piece_to_eat.nil?
    @moves_history << {
      move: move,
      pieces_eaten: piece_to_eat,
    }

    # print "eaten pieces: #{@pieces_eaten}\n"
    # print "moves history: #{@moves_history}\n"
  end

  def make_fake_move(move)

  end

  def move_valid?(player, move)
    start_pos, end_pos = move

    return false if selected_cell_empty?(start_pos)
    return false if selected_opponent_piece?(player, start_pos)

    piece_to_move = cell_at(start_pos)
    return false unless ending_position_available?(piece_to_move, start_pos, end_pos)

    true
  end

  def selected_cell_empty?(start_pos)
    if cell_empty?(start_pos)
      puts 'you selected an empty cell, retry'
      return true
    end

    false
  end

  def selected_opponent_piece?(player, start_pos)
    selected_piece = cell_at(start_pos)

    if selected_piece.color != player.color
      puts "you selected an opponent's piece, retry"
      return true
    end

    false
  end

  def ending_position_available?(piece, start_pos, end_pos)
    unless piece.available_positions(start_pos, self).include?(end_pos)
      puts 'you selected an unavailable move, retry'
      return false
    end

    true
  end

  def cell_empty?(pos)
    cell_at(pos).nil?
  end

  def place_piece(piece, pos)
    row, col = pos
    @board[row][col] = piece
  end

  def place_new_pieces(entries)
    entries.each do |entry|
      entry[2].each do |pos|
        new_piece_color = entry[1]
        new_piece = entry[0].new(new_piece_color)
        place_piece(new_piece, pos)
      end
    end
  end

  def cell_at(pos)
    row, col = pos
    @board[row][col]
  end

  def clear_cell(pos)
    row, col = pos
    @board[row][col] = nil
  end

  def clear_board
    @board = Array.new(8) { Array.new(8, nil) }
  end
end