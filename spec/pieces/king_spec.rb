require_relative '../../lib/pieces/king'

require_relative '../../lib/board'

describe King do
  subject(:king) { King.new(:white) }

  describe '#available_positions' do
    context 'when board just got initialized' do
      it 'should return an empty array' do
        board = Board.new
        expect(king.available_positions([7, 4], board)).to eql([])
      end
    end

    context 'when king is in the middle of the board' do
      it 'should return near positions' do
        board = Board.new
        board.clear_board

        expect(king.available_positions([3, 3], board)).to eql([[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]].sort)
      end
    end

    context 'when king is at the edge of the board' do
      it 'should return neal cells on board' do
        board = Board.new
        board.clear_board

        expect(king.available_positions([4, 0], board)).to eql([[3, 0], [3, 1], [4, 1], [5, 1], [5, 0]].sort)
      end
    end

    context 'when king is at the edge of the board and can eat an opponent piece' do
      it 'should return all positions including the opponent piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :black, [[4, 1]]]
                               ])

        expect(king.available_positions([4, 0], board)).to eql([[3, 0], [3, 1], [4, 1], [5, 1], [5, 0]].sort)
      end
    end

    context 'when king is at the edge of the board and ally piece is in eating position' do
      it 'should return all positions excluding the opponent piece' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Knight, :white, [[4, 1]]]
                               ])

        expect(king.available_positions([4, 0], board)).to eql([[3, 0], [3, 1], [5, 1], [5, 0]].sort)
      end
    end

    context 'when can castle' do
      it 'should return all positions including rook position' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Rook, :white, [[7, 7]]]
                               ])

        expect(king.available_positions([7, 4], board)).to eql([[7, 3], [7, 5], [6, 3], [6, 4], [6, 5], [7, 7]].sort)
      end
    end
  end
end
