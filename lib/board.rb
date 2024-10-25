require_relative "chess_helper"
require_relative "player"

class Board
	include ChessHelper

	def initialize
		@board = Array.new(8) { Array.new(8) }
	end

	private
end