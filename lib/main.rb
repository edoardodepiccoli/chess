require_relative 'board'

board = Board.new
board.display_board
board.move_piece(1, 0, 2, 0)
board.display_board
