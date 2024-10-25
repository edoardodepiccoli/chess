require_relative "../lib/board"

describe Board do
	subject(:board) { Board.new }

	describe "#make_move" do
		context "when a move is made" do
			it "should change the board" do
				expect { board.send(:make_move, "a2 a4") }.to change { board.board }
			end
		end
	end
end