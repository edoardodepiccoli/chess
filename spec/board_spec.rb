require "rspec"
require_relative "../lib/board"

describe Board do
	subject(:board) { described_class.new }

	describe "#coord_to_index" do
		context "when coordinates are valid" do
			it "should return 0 given (a, 8)" do
				expect(board.send(:coord_to_index, "a", 8)).to eql(0)
			end

			it "shohuld return 56 given (a, 1)" do
				expect(board.send(:coord_to_index, "a", 1)).to eql(56)
			end

			it "should return 12 given (e, 7)" do
				expect(board.send(:coord_to_index, "e", 7)).to eql(12)
			end

			it "should return 63 given (h, 1)" do
				expect(board.send(:coord_to_index, "h", 1)).to eql(63)
			end
		end

		context "when coordinates are not valid" do
			it "should return nil given (x, 0)" do
				expect(board.send(:coord_to_index, "x", 0)).to eql(nil)
			end

			it "should return nil given (a, 99)" do
				expect(board.send(:coord_to_index, "a", 99)).to eql(nil)
			end
		end
	end
end