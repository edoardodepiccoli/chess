require_relative "../lib/chess_helper"

describe ChessHelper do
	describe "#parse_algebraic" do
		context "when given a single algebraic position" do
			it "should return [0, 0] if given 'a8'" do
				expect(ChessHelper.parse_algebraic("a8")).to eql([0, 0])
			end

			it "should return [3, 2] if given 'c5" do
				expect(ChessHelper.parse_algebraic("c5")).to eql([3, 2])
			end
		end
	end

	describe "#parse_algebraic_move" do
		context "when given two algebraic positions separated by a space" do
			it "should return [[0, 0], [2, 3]] if given 'a8 d6'" do
				expect(ChessHelper.parse_algebraic_move("a8 d6")).to eql([[0, 0], [2, 3]])
			end

			it "should return [[0, 0], [7, 7]] if given 'a2 h8'" do
				expect(ChessHelper.parse_algebraic_move("a2 h8")).to eql([[6, 0], [0, 7]])
			end
		end
	end

	describe "#parse_coordinates" do
		context "when given coordinates" do
			it "should return a8 given [0, 0]'" do
				expect(ChessHelper.parse_coordinates([0, 0])).to eql("a8")
			end

			it "should return d6 given [2, 3]'" do
				expect(ChessHelper.parse_coordinates([2, 3])).to eql("d6")
			end
		end
	end
end