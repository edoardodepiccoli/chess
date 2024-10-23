require "rspec"
require_relative "../lib/board"

describe Board do
	subject(:board) { described_class.new }

	describe "#coord_to_index" do
		context "when coordinates are valid" do
			it "should return 0 given (a, 8)" do
				expect(board.coord_to_index("a", 8)).to eql(0)
			end

			it "shohuld return 56 given (a, 1)" do
				expect(board.coord_to_index("a", 1)).to eql(56)
			end

			it "should return 12 given (e, 7)" do
				expect(board.coord_to_index("e", 7)).to eql(12)
			end

			it "should return 63 given (h, 1)" do
				expect(board.coord_to_index("h", 1)).to eql(63)
			end
		end

		context "when coordinates are not valid" do
			it "should return [nil, nil] given (x, 0)" do
				expect(board.coord_to_index("x", 0)).to eql([nil, nil])
			end

			it "should return [nil, nil] given (a, 99)" do
				expect(board.coord_to_index("a", 99)).to eql([nil, nil])
			end
		end
	end

	describe "#index_to_coord" do
		context "when coordinates are valid" do
			it "should return [a, 8] when given 0" do
				expect(board.index_to_coord(0)).to eql(["a", 8])
			end

			it "should return [a, 1] when given 56" do
				expect(board.index_to_coord(56)).to eql(["a", 1])
			end

			it "should return [e, 7] when given 12" do
				expect(board.index_to_coord(12)).to eql(["e", 7])
			end

			it "should return [h, 1] when given 63" do
				expect(board.index_to_coord(63)).to eql(["h", 1])
			end
		end

		context "when coordinates are not valid" do
			it "should return [nil, nil] when given 999" do
				expect(board.index_to_coord(999)).to eql([nil, nil])
			end

			it "should return [nil, nil] when given -12" do
				expect(board.index_to_coord(-12)).to eql([nil, nil])
			end
		end
	end
end