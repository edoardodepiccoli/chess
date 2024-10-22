require_relative "../../lib/pieces/bishop"

describe Bishop do
	subject(:bishop) { described_class.new }

	describe "#initialize" do
		it "should initialize to white by default" do
			piece = described_class.new
			expect(piece.color).to eql("white")
		end

		it "should initialize to black if argument black given" do
			piece = described_class.new("black")
			expect(piece.color).to eql("black")
		end
	end

	describe "#possible_moves" do
		context "when bishop in index 26 => (c, 5)" do
			it "should return [5, 8, 12, 17, 19, 33, 35, 40, 44, 53, 62]" do
				expect(bishop.possible_moves(26)).to eql([5, 8, 12, 17, 19, 33, 35, 40, 44, 53, 62])
			end
		end

		context "when bishop in index 0 => (a, 8)" do
			it "should return [9, 18, 27, 36, 45, 54, 63]" do
				expect(bishop.possible_moves(0)).to eql([9, 18, 27, 36, 45, 54, 63])
			end
		end

		context "when bishop in index 20 => (e, 6)" do
			it "should return [2, 6, 11, 13, 27, 29, 34, 38, 41, 47, 56]" do
				expect(bishop.possible_moves(20)).to eql([2, 6, 11, 13, 27, 29, 34, 38, 41, 47, 48])
			end
		end
	end
end