require_relative "../lib/board"

require_relative"../lib/pieces/king"

describe Board do
	subject(:board) { Board.new }
	let(:player) { double }

	describe "#make_move" do
		context "when a move is made" do
			it "should change the board" do
				expect { board.send(:make_move, "a2 a4") }.to change { board.board }
			end
		end
	end

	describe "#move_valid?" do
		context "when the target is an empty cell" do
			it "should return false if board is empty" do
				board.send(:clear_board)

				expect(board.send(:move_valid?, player, "a2 a4")).to eql(false)
			end

			it "should return false if board is not empty but seleted cell is" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :white, ["b3"]]])

				expect(board.send(:move_valid?, player, "a2 a4")).to eql(false)
			end
		end

		context "when the starting target is an opponent's piece" do
			it "should return false" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :black, ["b3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:move_valid?, player, "b3 a4")).to eql(false)
			end
		end
	end

	describe "#selected_right_color?" do
		context "when the starting target is one own piece" do
			it "should return true" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :white, ["a3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:selected_right_color?, player, "a3 a4")).to eql(true)
			end
		end

		context "when the starting target is not one own piece" do
			it "should return false" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :black, ["a3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:selected_right_color?, player, "a3 a4")).to eql(false)
			end
		end
	end

	describe "#selected_empty_cell?" do
		context "when the starting target is an empty cell" do
			it "should return true" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :white, ["a3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:selected_empty_cell?, "a4 a5")).to eql(true)
			end
		end

		context "when the starting target is not an empty cell" do
			it "should return false" do
				board.send(:clear_board)
				board.send(:place_new_pieces, [[King, :white, ["a4"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:selected_empty_cell?, "a4 a5")).to eql(false)
			end
		end
	end

	describe "#move_is_available?" do
		context "when selected is move is available to piece" do
			it "should return true" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [[King, :white, ["a3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:move_is_available?, player, "a3 a2")).to eql(true)
			end
		end
	end

	describe "#move_is_available?" do
		context "when selected is move is not available to piece" do
			it "should return false" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [[King, :white, ["a3"]]])

				allow(player).to receive(:color).and_return(:white)

				expect(board.send(:move_is_available?, player, "a3 d2")).to eql(false)
			end
		end
	end
end





















