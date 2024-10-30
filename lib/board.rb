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

  attr_reader :moves_history

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }

    place_new_pieces(
      [
        [Pawn, :black, [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]],
        [Rook, :black, [[0, 0], [0, 7]]],
        [Knight, :black, [[0, 1], [0, 6]]],
        [Bishop, :black, [[0, 2], [0, 5]]],
        [Queen, :black, [[0, 3]]],
        [King, :black, [[0, 4]]],
        [Pawn, :white, [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]]],
        [Rook, :white, [[7, 0], [7, 7]]],
        [Knight, :white, [[7, 1], [7, 6]]],
        [Bishop, :white, [[7, 2], [7, 5]]],
        [Queen, :white, [[7, 3]]],
        [King, :white, [[7, 4]]],
      ]
    )

    @pieces_eaten = []
    @moves_history = []
  end

  def make_move(move)
    start_pos, end_pos = move

    piece_to_move = cell_at(start_pos)
    piece_to_eat = cell_at(end_pos)

    place_piece(piece_to_move, end_pos)
    clear_cell(start_pos)

    @pieces_eaten << piece_to_eat unless piece_to_eat.nil? || piece_to_eat.color == piece_to_move.color
    @moves_history << {
      piece: piece_to_move,
      move: move,
      piece_eaten: piece_to_eat,
    }

    perform_en_passant if last_move_was_en_passant?
    if piece_to_move.is_a?(King) || piece_to_move.is_a?(Rook)
      piece_to_move.not_moved_yet = false
    end

    if piece_to_move.is_a?(King) && piece_to_eat.is_a?(Rook) && piece_to_move.color == piece_to_eat.color
      col_offset = end_pos[1] > start_pos[1] ? 1 : -1
      place_piece(piece_to_eat, [start_pos[0], start_pos[1] + col_offset])
    end

    perform_pawn_promotion if should_perform_pawn_promotion?
  end

  def perform_pawn_promotion
    last_move = @moves_history.last

    piece = last_move[:piece]
    start_pos, end_pos = last_move[:move]

    retrievable_pieces = @pieces_eaten.filter { |eaten_piece| eaten_piece.color == piece.color }

    retrievable_pieces.each_with_index do |piece, index|
      puts "#{index} - #{piece.class.name}"
    end

    print "please choose a piece to bring back (type the number): "
    user_input = gets.chomp

    until user_input.match?(/\A[0-#{retrievable_pieces.size}]\z/)
      print "please insert a valid index: "
      user_input = gets.chomp
    end

    user_input = user_input.to_i

    place_piece(retrievable_pieces[user_input], end_pos)
  end

  def should_perform_pawn_promotion?
    last_move = @moves_history.last

    piece = last_move[:piece]
    start_pos, end_pos = last_move[:move]

    end_row, end_col = end_pos

    return false unless piece.is_a?(Pawn)
    row_goal = piece.color == :white ? 0 : 7

    return false unless end_row == row_goal

    true
  end

  def perform_en_passant
    start_pos, end_pos = @moves_history.last[:move]
    end_row, end_col = end_pos

    pawn_color = cell_at(end_pos).color
    move_direction = pawn_color == :white ? -1 : 1

    remove_pos = [end_row - move_direction, end_col]
    @pieces_eaten << cell_at(remove_pos)
    @moves_history.last[:piece_eaten] = cell_at(remove_pos)

    clear_cell(remove_pos)
  end

  def cell_empty?(pos)
    cell_at(pos).nil?
  end

  def last_move_was_en_passant?
    second_last_move = @moves_history[-2]
    return false if second_last_move.nil?

    last_move = @moves_history[-1]

    start_pos, end_pos = last_move[:move] unless last_move[:move].nil?
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    piece = cell_at(end_pos)

    return false unless move_enables_en_passant?(second_last_move)
    return false unless piece.is_a?(Pawn)
    return false if start_col == end_col

    move_direction = piece.color == :white ? -1 : 1
    piece_behind = cell_at([end_row - move_direction, end_col])
    return true if piece_behind.is_a?(Pawn) && piece_behind.color != piece.color

    false
  end

  def move_enables_en_passant?(move_entry)
    start_pos, end_pos = move_entry[:move]

    start_row, _start_col = start_pos
    end_row, _end_col = end_pos

    piece = move_entry[:piece]

    return true if piece.is_a?(Pawn) && ((end_row - start_row).abs == 2)

    false
  end

  def make_fake_move(move)
    start_pos, end_pos = move

    piece_to_move = cell_at(start_pos)

    place_piece(piece_to_move, end_pos)
    clear_cell(start_pos)
  end

  def dangerous_move?(player, move)
    color = player.color

    temp = @board.map(&:dup)

    make_fake_move(move)
    if king_in_danger?(color)
      puts 'move leaves the king in danger, try another one'
      @board = temp.map(&:dup)
      return true
    end

    @board = temp.map(&:dup)
    false
  end

  def checkmate?(player)
    return true unless player_has_available_moves?(player)

    false
  end

  def player_has_available_moves?(player)
    all_available_moves = []

    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        next if piece.nil? || piece.color != player.color

        all_available_moves += piece.available_positions([row_index, col_index], self).map { |end_pos| [[row_index, col_index], end_pos] }
      end
    end

    return false if all_available_moves.all? { |move| dangerous_move?(player, move) }

    true
  end

  def king_in_danger?(color)
    king_position = find_king(color)

    all_opponent_positions = []

    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        all_opponent_positions += piece.available_positions([row_index, col_index], self) if piece.is_a?(Piece) && piece.color != color
      end
    end

    all_opponent_positions.include?(king_position)
  end

  def find_king(color)
    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        return [row_index, col_index] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  # enable en passant
  # was en passant

  def move_valid?(player, move)
    start_pos, end_pos = move

    return false if selected_cell_empty?(start_pos)
    return false if selected_opponent_piece?(player, start_pos)

    piece_to_move = cell_at(start_pos)
    return false unless ending_position_available?(piece_to_move, start_pos, end_pos)
    return false if dangerous_move?(player, move)

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