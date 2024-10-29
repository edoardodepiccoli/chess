require_relative '../../lib/pieces/queen'

require_relative '../../lib/board'

describe Queen do
  subject(:queen) { Queen.new(:white) }

  describe '#available_positions' do
    context 'when board just got initialized' do
      it 'should return an empty array' do
        board = Board.new

        expect(queen.available_positions([7, 3], board)).to eql([])
      end
    end

    context 'when board is empty and queen is in the middle of it' do
      it 'should return all possitle horizontal, vertical and diagonal directions' do
        board = Board.new
        board.clear_board

        expect(queen.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6], [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 7], [2, 7], [4, 7], [2, 5], [1, 4], [0, 3], [4, 5], [5, 4], [6, 3], [7, 2]].sort)
      end
    end

    context 'when board is empty, queen is in the middle of it and can eat an opponent piece' do
      it 'should return all possitle positions except the ones after the opponent piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :black, [[5, 4]]]
                               ])

        expect(queen.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6], [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 7], [2, 7], [4, 7], [2, 5], [1, 4], [0, 3], [4, 5], [5, 4]].sort)
      end
    end

    context 'when board is empty, queen is in the middle of it and an ally piece is blocking the path' do
      it 'should return all possitle positions except the ones starting from the ally piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :white, [[5, 4]]]
                               ])

        expect(queen.available_positions([3, 6], board)).to eql([[0, 6], [1, 6], [2, 6], [4, 6], [5, 6], [6, 6], [7, 6], [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 7], [2, 7], [4, 7], [2, 5], [1, 4], [0, 3], [4, 5]].sort)
      end
    end
  end
end