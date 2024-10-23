require_relative "../../lib/pieces/king"

describe King do
	subject(:king) { described_class.new }

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
		context "when king in 0 => (a, 8)" do
			it "should return [1, 8, 9]" do
				expect(king.possible_moves(0)).to eql([1, 8, 9])
			end
		end

		context "when king in 53 => (f, 2)" do
			it "should return [44, 45, 46, 52, 54, 60, 61, 62]" do
				expect(king.possible_moves(53)).to eql([44, 45, 46, 52, 54, 60, 61, 62])
			end
		end
	end
end