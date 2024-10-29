require_relative '../../lib/pieces/knight'

require_relative '../../lib/board'

describe Knight do
  subject(:knight) { Knight.new(:white) }

  describe '#available_positions' do

    context 'when board just got initialized' do
      it 'should return two positions' do
        board = Board.new

        expect(knight.available_positions([7, 1], board)).to eql([[5, 0], [5, 2]].sort)
      end
    end

    context 'when it is in the middle of an empty board' do
      it 'should return eight positions' do
        board = Board.new
        board.clear_board

        expect(knight.available_positions([4, 5], board)).to eql([[6, 4], [5, 3], [3, 3], [2, 4], [2, 6], [3, 7], [5, 7], [6, 6]].sort)
      end
    end

    context 'when it is in the middle of an empty board and an opponent piece is in eating position' do
      it 'should return eight positions including the one where the opponent piece is standing' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Pawn, :black, [[6, 4]]]
                               ])

        expect(knight.available_positions([4, 5], board)).to eql([[6, 4], [5, 3], [3, 3], [2, 4], [2, 6], [3, 7], [5, 7], [6, 6]].sort)
      end
    end

    context 'when it is in the middle of an empty board and an ally piece is in eating position' do
      it 'should return eight positions excluding the one where the opponent piece is standing' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Pawn, :white, [[6, 4]]]
                               ])

        expect(knight.available_positions([4, 5], board)).to eql([[5, 3], [3, 3], [2, 4], [2, 6], [3, 7], [5, 7], [6, 6]].sort)
      end
    end

    context 'when it is at the edge of the board' do
      it 'should return four positions' do
        board = Board.new
        board.clear_board

        expect(knight.available_positions([3, 0], board)).to eql([[1, 1], [2, 2], [4, 2], [5, 1]].sort)
      end
    end
  end
end