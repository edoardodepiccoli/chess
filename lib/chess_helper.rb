module ChessHelper
	MAPPING = {
		"a" => 0,
		"b" => 1,
		"c" => 2,
		"d" => 3,
		"e" => 4,
		"f" => 5,
		"g" => 6,
		"h" => 7
	}

	def self.parse_algebraic(algebraic_position)
		letter, number = algebraic_position.split("")

		x = MAPPING[letter]
		y = 8 - (number.to_i)

		return [x, y]
	end

	def self.parse_algebraic_move(algebraic_move)
		start_position, end_position = algebraic_move.split(" ")
		start_position = parse_algebraic(start_position)
		end_position = parse_algebraic(end_position)

		return [start_position, end_position]
	end
end