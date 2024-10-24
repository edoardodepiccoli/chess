require_relative 'board'
require_relative 'player'

class Game
	def initialize
		@player_white = Player.new(:white)
		@player_black = Player.new(:black)
		@board = Board.new

		@turn = :white
	end

	def play
		play_round
	end

	def play_round
		system("clear")
		@board.display_board

		handle_player_move
		switch_turn

		play_round
	end

	def handle_player_move
		# get a valid move
		start_row, start_col, end_row, end_col = get_player_move
		
		# make the move	
		@board.make_move(start_row, start_col, end_row, end_col)
	end

	def get_player_move
		current_player = @turn == :white ? @player_white : @player_black
		loop do
			player_input = current_player.get_input

			# verify if the input format is a valid chess move
			if input_valid?(player_input)
				start_row, start_col = [player_input[0].to_i, player_input[1].to_i]
				end_row, end_col = [player_input[3].to_i, player_input[4].to_i]

				# verify if move is valid according to the board
				return [start_row, start_col, end_row, end_col] if @board.move_valid?(start_row, start_col, end_row, end_col, current_player.color)
			end
		end
	end

	def input_valid?(player_input)
		unless player_input.match(/^[0-7]{2} [0-7]{2}$/)
			puts "move format invalid, retry"
			return false
		end
		true
	end

	def switch_turn
		@turn = @turn == :white ? :black : :white
	end

	def test
		@board.display_board
		@board.move_piece(1, 0, 2, 0)

		print "\n"
		@board.display_board
	end
end