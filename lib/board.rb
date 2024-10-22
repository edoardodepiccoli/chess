class Board
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

	def initialize
		@board = Array.new(64)
	end

	private

	def coord_to_index(x, y)
		return nil unless MAPPING.keys.include?(x) && (1..8).include?(y)

		x_coord = MAPPING[x]
		y_coord = (8 - (y))

		index = y_coord * 8 + x_coord
	end
end