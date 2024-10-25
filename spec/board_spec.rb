require_relative "../lib/board"

require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'

describe Board do
	describe "#king_in_check?" do
		context "when king is not in check" do
			board = Board.new
			it "should return false" do
				expect(board.king_in_check?(:white)).to eql(false)
			end 
		end

		context "when king is in check" do
			board = Board.new
			board.clear_board
			
			board.place_piece(King.new(:white), 0, 7)
			board.place_piece(Knight.new(:black), 1, 5)

			it "should return true" do
				expect(board.king_in_check?(:white)).to eql(true)
			end 
		end
	end
end