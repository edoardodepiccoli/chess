require_relative "../../lib/pieces/pawn"

describe Pawn do
	subject(:pawn) { described_class.new }

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
		context "when pawn in 0 => (a, 8)" do
			it "should return []" do
				expect(pawn.possible_moves(0)).to eql([])
			end
		end

		context "when pawn in 8 => (a, 7)" do
			it "should return [0]" do
				expect(pawn.possible_moves(8)).to eql([0])
			end
		end

		context "when pawn in 28 => (e, 5)" do
			it "should return [12, 20]" do
				expect(pawn.possible_moves(28)).to eql([12, 20])
			end
		end
	end
end