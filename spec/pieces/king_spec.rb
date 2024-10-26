require_relative "../../lib/board"
require_relative "../../lib/pieces/king"

describe King do
	subject(:king) { King.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(king.available_moves([7, 4], board)).to eql([])
			end
		end

		context "when no other piece is around" do
			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				expect(king.available_moves([2, 1], board)).to eql([[1, 0], [1, 1], [1, 2], [2, 0], [2, 2], [3, 0], [3, 1], [3, 2]].sort)
			end

			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				expect(king.available_moves([2, 0], board)).to eql([[1, 0], [1, 1], [2, 1], [3, 0], [3, 1]].sort)
			end
		end

		context "when an opponent piece is near him" do
			it "should return near cells" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Pawn, :black, ["b7"]]
				])

				expect(king.available_moves([2, 1], board)).to eql([[1, 0], [1, 1], [1, 2], [2, 0], [2, 2], [3, 0], [3, 1], [3, 2]].sort)
			end
		end
	end
end