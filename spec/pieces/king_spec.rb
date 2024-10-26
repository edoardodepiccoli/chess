require_relative "../../lib/pieces/king"
require_relative "../../lib/board"

describe King do
	subject(:king) { King.new(:white) }

	describe "#available_moves" do
		context "when board has just been initialized" do
			it "should return empty array" do
				board = Board.new

				expect(king.available_moves([4, 7], board)).to eql([])
			end
		end

		context "when king is the only one in the board" do
			it "should return near empty cells" do
				board = Board.new
				board.send(:clear_board)

				expect(king.available_moves([4, 7], board)).to eql([[3, 7], [5, 7], [3, 6], [4, 6], [5, 6]].sort)
			end
		end
	end
end