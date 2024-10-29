require_relative '../lib/board'

describe Board do
  subject(:board) { Board.new }

  describe '#king_in_danger?' do
    context 'when king is in danger' do
      it 'should return true' do
        board.clear_board
        board.place_new_pieces([
                                 [Knight, :black, [[5, 2]]],
                                 [King, :white, [[4, 4]]]
                               ])
        expect(board.king_in_danger?(:white)).to eql(true)
      end
    end

    context 'when king is not in danger' do
      it 'should return false' do
        board.clear_board
        board.place_new_pieces([
                                 [Knight, :black, [[5, 1]]],
                                 [King, :white, [[4, 4]]]
                               ])
        expect(board.king_in_danger?(:white)).to eql(false)
      end
    end
  end

  describe '#dangerous_move?' do
    context 'when move is dangerous' do
      it 'should return true' do
        board.clear_board
        board.place_new_pieces([
                                 [Knight, :black, [[5, 2]]],
                                 [King, :white, [[3, 3]]]
                               ])

        player = double
        allow(player).to receive(:color).and_return(:white)

        expect(board.dangerous_move?(player, [[3, 3], [4, 4]])).to eql(true)
      end
    end

    context 'when move is not dangerous' do
      it 'should return true' do
        board.clear_board
        board.place_new_pieces([
                                 [Knight, :black, [[5, 2]]],
                                 [King, :white, [[4, 4]]]
                               ])

        player = double
        allow(player).to receive(:color).and_return(:white)

        expect(board.dangerous_move?(player, [[4, 4], [5, 5]])).to eql(false)
      end
    end
  end

  describe '#checkmate?' do
    context 'when it is not checkmate' do
      it 'should return false' do
        board = Board.new

        player = double
        allow(player).to receive(:color).and_return(:white)

        expect(board.checkmate?(player)).to eql(false)
      end

      it "should return false" do
        board.clear_board
        board.place_new_pieces([
                                 [Rook, :white, [[7, 0]]],
                                 [Rook, :black, [[0, 0]]],
                                 [King, :white, [[0, 7]]],
                               ])

        player = double
        allow(player).to receive(:color).and_return(:white)

        expect(board.checkmate?(player)).to eql(false)
      end
    end

    context 'when it is checkmate' do
      it 'should return true' do
        board.clear_board
        board.place_new_pieces([
                                 [Rook, :black, [[7, 7]]],
                                 [Rook, :black, [[0, 0]]],
                                 [Bishop, :black, [[7, 0]]],
                                 [King, :white, [[0, 7]]],
                               ])

        player = double
        allow(player).to receive(:color).and_return(:white)

        expect(board.checkmate?(player)).to eql(true)
      end
    end
  end
end