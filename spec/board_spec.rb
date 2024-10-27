require_relative "../lib/board"

describe Board do
	subject(:board) { Board.new }

	describe "#find_king" do
		context "when board just initialized" do
			it "should return e1 given white" do
				expect(board.send(:find_king, :white)).to eql("e1")
			end
		end
	end

	describe "#king_in_danger?" do
		context "when king is not in danger" do
			it "should return false" do
				expect(board.send(:king_in_danger?, :white)).to eql(false)
			end

			it "should return false" do
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[King, :white, ["e4"]], 
					[Knight, :black, ["f5"]]
				])

				expect(board.send(:king_in_danger?, :white)).to eql(false)
			end
		end

		context "when king is in danger" do
			it "should return true" do
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[King, :white, ["e4"]], 
					[Knight, :black, ["d6"]]
				])

				expect(board.send(:king_in_danger?, :white)).to eql(true)
			end
		end

		context "when king is in danger" do
			it "should return true" do
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[King, :white, ["e4"]], 
					[Pawn, :black, ["f5"]]
				])

				expect(board.send(:king_in_danger?, :white)).to eql(true)
			end
		end
	end

	describe "#move_leaves_king_in_danger?" do
		context "when move does not leave the king in danger" do
			it "should return false" do
				player = double
				allow(player).to receive(:color).and_return(:white)

				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[King, :white, ["e2"]], 
					[Pawn, :black, ["f5"]]
				])

				expect(board.send(:move_leaves_king_in_danger?, player, "e2 e3")).to eql(false)
			end
		end

		context "when move does leave the king in danger" do
			it "should return false" do
				player = double
				allow(player).to receive(:color).and_return(:white)

				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[King, :white, ["e3"]], 
					[Pawn, :black, ["f5"]]
				])

				expect(board.send(:move_leaves_king_in_danger?, player, "e3 e4")).to eql(true)
				expect(board.send(:find_king, :white)).to eql("e3")
			end
		end
	end
end











