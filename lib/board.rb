require_relative "chess_helper"
require_relative "./pieces/rook"
require_relative "./pieces/knight"
require_relative "./pieces/bishop"
require_relative "./pieces/queen"
require_relative "./pieces/king"
require_relative "./pieces/pawn"

require "colorize"

class Board
	include ChessHelper

	def initialize
		@board = [
			Rook.new("black"), Knight.new("black"), Bishop.new("black"), Queen.new("black"), King.new("black"), Bishop.new("black"), Knight.new("black"), Rook.new("black"),
			Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), Pawn.new("black"), 
			nil, nil, nil, nil, nil, nil, nil, nil, 
			nil, nil, nil, nil, nil, nil, nil, nil, 
			nil, nil, nil, nil, nil, nil, nil, nil, 
			nil, nil, nil, nil, nil, nil, nil, nil,
			Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), Pawn.new("white"), 
			Rook.new("white"), Knight.new("white"), Bishop.new("white"), Queen.new("white"), King.new("white"), Bishop.new("white"), Knight.new("white"), Rook.new("white"),
		]
	end

	def display_board
		print " abcdefgh\n"
		@board.each_with_index do |cell, index|
			if (index % 8).zero? && !index.zero?
				print "#{8 - (index / 8)}\n"
			end

			if (index % 8).zero?
				print 8 - (index / 8)
			end

			if cell.nil?
				print " ".colorize(:background => :red) if square_color(index) == "dark"
				print " ".colorize(:background => :white) if square_color(index) == "light"
			else
				unicode_chr = ""
				unicode_chr = cell.unicode[0] if cell.color == "white"
				unicode_chr = cell.unicode[1] if cell.color == "black"

				print unicode_chr.colorize(:background => :red) if square_color(index) == "dark"
				print unicode_chr.colorize(:background => :white) if square_color(index) == "light"
			end
		end
		print "1\n"
		print " abcdefgh\n"
	end

	private

	def square_color(index)
	  row = index / 8
	  col = index % 8

	  if (row + col).even?
	    return "light"
	  else
	    return "dark"
	  end
	end
end