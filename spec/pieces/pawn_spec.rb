require_relative "../../lib/board"
require_relative "../../lib/pieces/pawn"

describe King do
	subject(:white_pawn) { Pawn.new(:white) }
	subject(:black_pawn) { Pawn.new(:black) }

	describe "#available_moves" do
		context "after board just got initialized and pawn has not yet moved" do
			it "should return two vertical moves" do
				board = Board.new

				expect(white_pawn.available_moves("b2", board)).to eql(["b3", "b4"].sort)
			end

			it "should return two vertical moves" do
				board = Board.new

				expect(black_pawn.available_moves("e7", board)).to eql(["e6", "e5"].sort)
			end
		end

		context "when nothing is in front of him" do
			it "should return one vertical moves" do
				board = Board.new
				board.send(:clear_board)

				expect(white_pawn.available_moves("b3", board)).to eql(["b4"])
			end

			it "should return one vertical moves" do
				board = Board.new
				board.send(:clear_board)

				expect(black_pawn.available_moves("e5", board)).to eql(["e4"])
			end
		end

		context "when opponent piece is in front of him" do
			it "should return empty array" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["e4"]]
				])

				expect(white_pawn.available_moves("e3", board)).to eql([])
			end

			it "should return empty array" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["e4"]]
				])

				expect(black_pawn.available_moves("e5", board)).to eql([])
			end
		end

		context "when ally piece is in front of him" do
			it "should return empty array" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["b7"]]
				])

				expect(white_pawn.available_moves("b6", board)).to eql([])
			end

			it "should return empty array" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["b4"]]
				])

				expect(black_pawn.available_moves("b5", board)).to eql([])
			end
		end

		context "when another enemy piece is places in eating position and pawn has not moved yet" do
			it "should return two vertical moves and one diagonal move" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["e3"]]
				])

				expect(white_pawn.available_moves("d2", board)).to eql(["d3", "d4", "e3"].sort)
			end
		end 

		context "when another enemy piece is places in eating position and pawn has already moved" do
			it "should return one vertical moves and one diagonal move" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["c5"]]
				])

				expect(white_pawn.available_moves("d4", board)).to eql(["d5", "c5"].sort)
			end
		end

		context "when another ally piece is in eating position and pawn has not moved yet" do
			it "should return two vertical moves" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :white, ["e3"]]
				])

				expect(white_pawn.available_moves("d2", board)).to eql(["d3", "d4"].sort)
			end
		end 

		context "when another enemy piece is in eating position and pawn has already moved" do
			it "should return one vertical moves and one diagonal move" do
				board = Board.new
				board.send(:clear_board)

				board.send(:place_new_pieces, [
					[Knight, :black, ["c5"]]
				])

				expect(white_pawn.available_moves("d4", board)).to eql(["d5", "c5"].sort)
			end
		end 
	end
end





















