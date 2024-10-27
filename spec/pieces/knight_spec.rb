require_relative "../../lib/board"
require_relative "../../lib/pieces/knight"

describe Knight do
	subject(:knight) { Knight.new(:white) }

	describe "#available_moves" do
		context "after board just god initialized" do
			it "should return empty array" do
				board = Board.new

				expect(knight.available_moves("b1", board)).to eql(["a3", "c3"].sort)
			end
		end

		context "when board is empty and knight is in the middle of it" do
			it "should return 8 possible moves" do
				board = Board.new
				board.send(:clear_board)

				expect(knight.available_moves("e4", board)).to eql(["d2", "c3", "c5", "d6", "f6", "g5", "g3", "f2"].sort)
			end
		end

		context "when board is empty and knight is at the left edge of it" do
			it "should return 4 possible moves" do
				board = Board.new
				board.send(:clear_board)

				expect(knight.available_moves("a4", board)).to eql(["b2", "c3", "c5", "b6"].sort)
			end
		end

		context "when one position is already occupied by ally piece" do
			it "should return all available cells expect that one" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["c3"]]
				])

				expect(knight.available_moves("a4", board)).to eql(["b2", "c5", "b6"].sort)
			end
		end

		context "when one position is already occupied by enemy piece" do
			it "should return all available cells including that one" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["c3"]]
				])

				expect(knight.available_moves("a4", board)).to eql(["b2", "c3", "c5", "b6"].sort)
			end
		end
	end
end