require_relative "../../lib/pieces/knight"

describe Knight do
	subject(:knight) { described_class.new }

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
		context "when knight in 0 => (a, 8)" do
			it "should return [10, 17]" do
				expect(knight.possible_moves(0)).to eql([10, 17])
			end
		end

		context "when knight in 21 => (f, 6)" do
			it "should return [4, 6, 11, 15, 27, 31, 36, 38]" do
				expect(knight.possible_moves(21)).to eql([4, 6, 11, 15, 27, 31, 36, 38])
			end
		end
	end
end