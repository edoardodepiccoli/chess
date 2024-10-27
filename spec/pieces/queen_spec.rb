require_relative "../../lib/board"
require_relative "../../lib/pieces/queen"

describe Queen do
	subject(:queen) { Queen.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(queen.available_moves("d1", board)).to eql([])
			end
		end

		context "when no other piece is around" do
			it "should return all cells in possible directions" do
				board = Board.new
				board.send(:clear_board)

				expect(queen.available_moves("g5", board)).to eql(["h6", "h5", "h4", "g1", "g2", "g3", "g4", "g6", "g7", "g8", "d8", "e7", "f6", "f4", "e3", "d2", "c1", "a5", "b5", "c5", "d5", "e5", "f5"].sort)
			end
		end

		context "when an ally piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["d5"]]
				])

				expect(queen.available_moves("g5", board)).to eql(["h6", "h5", "h4", "g1", "g2", "g3", "g4", "g6", "g7", "g8", "d8", "e7", "f6", "f4", "e3", "d2", "c1", "e5", "f5"].sort)
			end

			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["f6"]]
				])

				expect(queen.available_moves("g5", board)).to eql(["h6", "h5", "h4", "g1", "g2", "g3", "g4", "g6", "g7", "g8", "f4", "e3", "d2", "c1", "a5", "b5", "c5", "d5", "e5", "f5"].sort)
			end
		end

		context "when an enemy piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["d5"]]
				])

				expect(queen.available_moves("g5", board)).to eql(["h6", "h5", "h4", "g1", "g2", "g3", "g4", "g6", "g7", "g8", "d8", "e7", "f6", "f4", "e3", "d2", "c1", "d5", "e5", "f5"].sort)
			end

			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["f6"]]
				])

				expect(queen.available_moves("g5", board)).to eql(["h6", "h5", "h4", "g1", "g2", "g3", "g4", "g6", "g7", "g8", "f4", "e3", "d2", "c1", "a5", "b5", "c5", "d5", "e5", "f5", "f6"].sort)
			end
		end
	end
end