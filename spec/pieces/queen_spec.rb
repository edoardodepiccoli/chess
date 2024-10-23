require_relative "../../lib/pieces/queen"

describe Queen do
	subject(:queen) { described_class.new }

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
		context "when queen in 0 => (a, 8)" do
			it "should return [1, 2, 3, 4, 5, 6, 7, 8, 9, 16, 18, 24, 27, 32, 36, 40, 45, 54, 56, 63]" do
				expect(queen.possible_moves(0)).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 16, 18, 24, 27, 32, 36, 40, 45, 48, 54, 56, 63])
			end
		end

		# pain in the ass to test all the queen positions
		context "when queen in 21 => (f, 6)" do
			it "should return [3, 7, 12, 14, 28, 30, 35, 39, 42, 49, 56]" do
				expect(queen.possible_moves(21)).to eql([3, 5, 7, 12, 13, 14, 16, 17, 18, 19, 20, 22, 23, 28, 29, 30, 35, 37, 39, 42, 45, 49, 53, 56, 61])
			end
		end
	end
end