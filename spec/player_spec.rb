require_relative '../lib/player'

describe Player do
  subject(:player) { Player.new(:white) }

  describe '#input_valid?' do
    context 'when given a valid input' do
      it 'should return true' do
        expect(player.send(:input_valid?, 'a1 c5')).to eql(true)
      end
    end

    context 'when given an invalid input' do
      it 'should return false' do
        expect(player.send(:input_valid?, 'a 23')).to eql(false)
      end

      it 'should return false' do
        expect(player.send(:input_valid?, '')).to eql(false)
      end

      it 'should return false' do
        expect(player.send(:input_valid?, '21 6')).to eql(false)
      end

      it 'should return false' do
        expect(player.send(:input_valid?, '-12 23')).to eql(false)
      end

      it 'should return false' do
        expect(player.send(:input_valid?, 'ab de')).to eql(false)
      end

      it 'should return false' do
        expect(player.send(:input_valid?, '00 02')).to eql(false)
      end
    end
  end
end
