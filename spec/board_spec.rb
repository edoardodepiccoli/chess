require 'rspec'
require_relative '../lib/board'

describe Board do
  subject(:board) { Board.new }

  describe '#find_king' do
    context 'when board just initialized' do
      it 'should return e1 given white' do
        expect(board.send(:find_king, :white)).to eql('e1')
      end
    end
  end

  describe '#king_in_danger?' do
    context 'when king is not in danger' do
      it 'should return false' do
        expect(board.send(:king_in_danger?, :white)).to eql(false)
      end

      it 'should return false' do
        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['e4']],
                     [Knight, :black, ['f5']]
                   ])

        expect(board.send(:king_in_danger?, :white)).to eql(false)
      end
    end

    context 'when king is in danger' do
      it 'should return true' do
        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['e4']],
                     [Knight, :black, ['d6']]
                   ])

        expect(board.send(:king_in_danger?, :white)).to eql(true)
      end
    end

    context 'when king is in danger' do
      it 'should return true' do
        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['e4']],
                     [Pawn, :black, ['f5']]
                   ])

        expect(board.send(:king_in_danger?, :white)).to eql(true)
      end
    end
  end

  describe '#move_leaves_king_in_danger?' do
    context 'when move does not leave the king in danger' do
      it 'should return false' do
        player = double
        allow(player).to receive(:color).and_return(:white)

        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['e2']],
                     [Pawn, :black, ['f5']]
                   ])

        expect(board.send(:move_leaves_king_in_danger?, player, 'e2 e3')).to eql(false)
      end
    end

    context 'when move does leave the king in danger' do
      it 'should return false' do
        player = double
        allow(player).to receive(:color).and_return(:white)

        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['e3']],
                     [Pawn, :black, ['f5']]
                   ])

        expect(board.send(:move_leaves_king_in_danger?, player, 'e3 e4')).to eql(true)
        expect(board.send(:find_king, :white)).to eql('e3')
      end
    end
  end

  describe '#checkmate?' do
    context 'when it is not checkmate' do
      it 'should return false' do
        player = double
        allow(player).to receive(:color).and_return(:white)

        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['h8']],
                     [Rook, :black, ['h1']]
                   ])

        expect(board.send(:checkmate?, player)).to eql(false)
      end

      it 'should return false' do
        player = double
        allow(player).to receive(:color).and_return(:white)

        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['h8']],
                     [Bishop, :black, ['a1']],
                     [Rook, :white, ['d1']]
                   ])

        expect(board.send(:checkmate?, player)).to eql(false)
      end
    end

    context 'when it is checkmate' do
      it 'should return true' do
        player = double
        allow(player).to receive(:color).and_return(:white)

        board.send(:clear_board)

        board.send(:place_new_pieces, [
                     [King, :white, ['h8']],
                     [Rook, :black, ['h1', 'a8']],
                     [Bishop, :black, ['a1']]
                   ])

        expect(board.send(:checkmate?, player)).to eql(true)
      end
    end
  end

  describe '#make_move' do
    context 'when pawn captures emeny pawn with en passant' do
      it 'should clear the cell containing the enemy pawn' do
        board = Board.new
        board.send(:clear_board)

        board.send(:place_new_pieces, [
          [Pawn, :black, ['f7']],
          [Pawn, :white, ['e5']]
        ])

        expect(board).to receive(:empty_cell).exactly(3).times

        board.make_move('f7 f5')
        board.make_move('e5 f6')
      end
    end
  end
end
