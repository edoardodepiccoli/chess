require_relative "chess_helper"

class Board
	include ChessHelper

	def initialize
		@board = Array.new(64)
	end
end