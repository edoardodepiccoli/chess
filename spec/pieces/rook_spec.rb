require_relative "../../lib/board"
require_relative "../../lib/pieces/rook"

describe Rook do
	subject(:rook) { Rook.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(rook.available_moves("h1", board)).to eql([])
			end
		end

		context "when no other piece is around" do
			it "should return all cells in possible directions" do
				board = Board.new
				board.send(:clear_board)

				expect(rook.available_moves("g5", board)).to eql(["a5", "b5", "c5", "d5", "e5", "f5", "h5", "g1", "g2", "g3", "g4", "g6", "g7", "g8"].sort)
			end
		end

		context "when an ally piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["d5"]]
				])

				expect(rook.available_moves("g5", board)).to eql(["e5", "f5", "h5", "g1", "g2", "g3", "g4", "g6", "g7", "g8"].sort)
			end

			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["g7"]]
				])

				expect(rook.available_moves("g5", board)).to eql(["a5", "b5", "c5", "d5", "e5", "f5", "h5", "g1", "g2", "g3", "g4", "g6"].sort)
			end
		end

		context "when an enemy piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["d5"]]
				])

				expect(rook.available_moves("g5", board)).to eql(["d5", "e5", "f5", "h5", "g1", "g2", "g3", "g4", "g6", "g7", "g8"].sort)
			end

			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["g7"]]
				])

				expect(rook.available_moves("g5", board)).to eql(["a5", "b5", "c5", "d5", "e5", "f5", "h5", "g1", "g2", "g3", "g4", "g6", "g7"].sort)
			end
		end
	end
end