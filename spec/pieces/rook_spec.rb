require_relative "../../lib/pieces/rook"

describe Rook do
	subject(:rook) { described_class.new }

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
		context "when rook in 0 => (a, 8)" do
			it "should return [1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56]" do
				expect(rook.possible_moves(0)).to eql([1, 2, 3, 4, 5, 6, 7, 8, 16, 24, 32, 40, 48, 56])
			end
		end

		context "when rook in 21 => (f, 6)" do
			it "should return [5, 13, 16, 17, 18, 19, 20, 22, 23, 29, 37, 45, 53, 61]" do
				expect(rook.possible_moves(21)).to eql([5, 13, 16, 17, 18, 19, 20, 22, 23, 29, 37, 45, 53, 61])
			end
		end
	end
end