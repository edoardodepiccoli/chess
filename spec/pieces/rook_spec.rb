require_relative '../../lib/pieces/rook'

require_relative '../../lib/board'

describe Rook do
  subject(:rook) { Rook.new(:white) }

  describe '#available_positions' do
    context 'when board just got initialized' do
      it 'should return an empty array' do
        board = Board.new

        expect(rook.available_positions([7, 7], board)).to eql([])
      end
    end

    context 'when board is empty and queen is in the middle of it' do
      it 'should return all possitle horizontal, vertical and diagonal directions' do
        board = Board.new
        board.clear_board

        expect(rook.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6], [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 7]].sort)
      end
    end

    context 'when board is empty, queen is in the middle of it and can eat an opponent piece' do
      it 'should return all possitle positions except the ones after the opponent piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :black, [[3, 3]]]
                               ])

        expect(rook.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6],[3, 3], [3, 4], [3, 5], [3, 7]].sort)
      end
    end

    context 'when board is empty, queen is in the middle of it and an ally piece is blocking the path' do
      it 'should return all possitle positions except the ones starting from the ally piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :white, [[3, 3]]]
                               ])

        expect(rook.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6], [3, 4], [3, 5], [3, 7]].sort)
      end
    end
  end
end