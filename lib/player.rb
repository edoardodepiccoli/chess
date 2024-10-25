class Player
	attr_reader :color

	def initialize(color)
		@color = color
	end

	def get_move
		input = gets.chomp

		until input_valid?(input)
			input = gets.chomp
		end

		input
	end

	private

	def input_valid?(input)
		input.match?(/^[a-h][1-8] [a-h][1-8]$/)
	end
end