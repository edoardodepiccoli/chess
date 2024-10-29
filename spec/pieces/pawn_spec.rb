require_relative '../../lib/pieces/pawn'

require_relative '../../lib/board'

describe Pawn do
  subject(:white_pawn) { Pawn.new(:white) }
  subject(:black_pawn) { Pawn.new(:black) }

  describe '#available_positions' do

    context 'when board just got initialized' do
      it 'white pawn should return two vertical moves' do
        board = Board.new
        expect(white_pawn.available_positions([6, 0], board)).to eql([[5, 0], [4, 0]].sort)
      end

      it 'black pawn should return two vertical moves' do
        board = Board.new
        expect(black_pawn.available_positions([1, 0], board)).to eql([[2, 0], [3, 0]].sort)
      end
    end

    context 'when pawn is in starting position and can eat an opponent piece' do
      it 'white pawn should return two vertical moves and on diagonal one' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :black, [[5, 1]]]
                               ])

        expect(white_pawn.available_positions([6, 0], board)).to eql([[5, 0], [4, 0], [5, 1]].sort)
      end

      it 'black pawn should return two vertical moves and on diagonal one' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :white, [[2, 1]]]
                               ])

        expect(black_pawn.available_positions([1, 0], board)).to eql([[2, 0], [3, 0], [2, 1]].sort)
      end
    end

    context 'when pawn is in starting position and an ally piece is in eating position' do
      it 'white pawn should return two vertical moves' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :white, [[5, 1]]]
                               ])

        expect(white_pawn.available_positions([6, 0], board)).to eql([[5, 0], [4, 0]].sort)
      end

      it 'black pawn should return two vertical moves' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :black, [[2, 1]]]
                               ])

        expect(black_pawn.available_positions([1, 0], board)).to eql([[2, 0], [3, 0]].sort)
      end
    end

    context 'when pawn is in the middle on the board' do
      it 'should return one vertical move' do
        board = Board.new

        expect(white_pawn.available_positions([4, 2], board)).to eql([[3, 2]].sort)
      end

      it 'should return one vertical move' do
        board = Board.new

        expect(black_pawn.available_positions([4, 2], board)).to eql([[5, 2]].sort)
      end
    end

    context 'when pawn is in the middle on the board and can eat an opponent piece' do
      it 'should return one vertical move' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :black, [[3, 3]]]
                               ])

        expect(white_pawn.available_positions([4, 2], board)).to eql([[3, 2], [3, 3]].sort)
      end

      it 'should return one vertical move' do
        board = Board.new
        board.place_new_pieces([
                                 [Knight, :white, [[5, 3]]]
                               ])

        expect(black_pawn.available_positions([4, 2], board)).to eql([[5, 2], [5, 3]].sort)
      end
    end

    context 'when can perform en passant' do
      it 'should show eating move for en passant available' do
        board = Board.new
        board.clear_board

        board.place_new_pieces([
                                 [Pawn, :black, [[1, 1]]],
                               ])
        board.make_move([[1, 1], [3, 1]])

        expect(white_pawn.available_positions([3, 0], board)).to eql([[2, 0], [2, 1]].sort)
      end
    end
  end
end