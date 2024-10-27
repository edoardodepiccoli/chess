require_relative "../../lib/board"
require_relative "../../lib/pieces/king"

describe King do
	subject(:king) { King.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(king.available_moves("e1", board)).to eql([])
			end
		end

		context "when no other piece is around" do
			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				expect(king.available_moves("b6", board)).to eql(["a5", "a6", "a7", "b5", "b7", "c5", "c6", "c7"].sort)
			end

			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				expect(king.available_moves("a6", board)).to eql(["a5", "a7", "b5", "b6", "b7"].sort)
			end
		end

		context "when an opponent piece is near him" do
			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Pawn, :black, ["b7"]]
				])

				expect(king.available_moves("b6", board)).to eql(["a5", "a6", "a7", "b5", "b7", "c5", "c6", "c7"].sort)
			end
		end
	end
end