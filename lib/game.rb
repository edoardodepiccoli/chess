require_relative "board"

class Game
	def initialize
		@board = Board.new
		@checkmate = false
	end

	def play
		loop do
			break if @checkmate

			@board.display_board
			puts "enter move: "
			move = gets.chomp
		end
	end
end