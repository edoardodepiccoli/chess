require_relative '../lib/player'

describe Player do
  subject(:player) { Player.new(:white) }

  describe '#input_valid?' do
    context 'when input is valid' do
      it "should return true if given 'a8 e6'" do
        expect(player.send(:input_valid?, 'a8 e6')).to eql(true)
      end

      it "should return true if given 'b3 d7'" do
        expect(player.send(:input_valid?, 'b3 d7')).to eql(true)
      end
    end

    context 'when input is not valid' do
      it "should return false if given 'z8 e6'" do
        expect(player.send(:input_valid?, 'z8 e6')).to eql(false)
      end

      it "should return false if given 'b9 d7'" do
        expect(player.send(:input_valid?, 'b9 d7')).to eql(false)
      end

      it "should return false if given ' d7'" do
        expect(player.send(:input_valid?, ' d7')).to eql(false)
      end

      it "should return false if given ''" do
        expect(player.send(:input_valid?, '')).to eql(false)
      end

      it "should return false if given 'asd2'" do
        expect(player.send(:input_valid?, 'asd2')).to eql(false)
      end
    end
  end
end
