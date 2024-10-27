require_relative "../../lib/board"
require_relative "../../lib/pieces/bishop"

describe Bishop do
	subject(:bishop) { Bishop.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(bishop.available_moves("c1", board)).to eql([])
			end
		end

		context "when no other piece is around" do
			it "should return all cells in possible directions" do
				board = Board.new
				board.send(:clear_board)

				expect(bishop.available_moves("g5", board)).to eql(["h6", "h4", "f6", "e7", "d8", "f4", "e3", "d2", "c1"].sort)
			end
		end

		context "when an ally piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["e7"]]
				])

				expect(bishop.available_moves("g5", board)).to eql(["h6", "h4", "f6", "f4", "e3", "d2", "c1"].sort)
			end

			it "should return all cells in possible directions expect blocked path cell where ally piece stands" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["e3"]]
				])

				expect(bishop.available_moves("g5", board)).to eql(["h6", "h4", "f6", "e7", "d8", "f4"].sort)
			end
		end

		context "when an enemy piece is blocking the direction" do
			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["e7"]]
				])

				expect(bishop.available_moves("g5", board)).to eql(["h6", "h4", "f6", "f4", "e3", "d2", "c1", "e7"].sort)
			end

			it "should return all cells in possible directions expect blocked path starting right after the enemy piece who is blocking the path" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["e3"]]
				])

				expect(bishop.available_moves("g5", board)).to eql(["h6", "h4", "f6", "e7", "d8", "f4", "e3"].sort)
			end
		end
	end
end