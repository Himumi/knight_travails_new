require_relative '../lib/travails'

describe Travails do
  subject(:game) { described_class.new }
  describe '#direction' do
    context 'when based position is D4 or [4, 3]' do
      it 'returns [3, 1] for direction 0' do
        expect(game.direction([4, 3], 0)).to eq([3, 1])
      end

      it 'returns [2, 2] for direction 1' do
        expect(game.direction([4, 3], 1)).to eq([2, 2])
      end

      it 'returns [2, 4] for direction 2' do
        expect(game.direction([4, 3], 2)).to eq([2, 4])
      end

      it 'returns [3, 5] for direction 3' do
        expect(game.direction([4, 3], 3)).to eq([3, 5])
      end

      it 'retunrs [5, 5] for direction 4' do
        expect(game.direction([4, 3], 4)).to eq([5, 5])
      end

      it 'returns [6, 4] for direction 5' do
        expect(game.direction([4, 3], 5)).to eq([6, 4])

      end

      it 'returns [6, 2] for direction 6' do
        expect(game.direction([4, 3], 6)).to eq([6, 2])
      end

      it 'returns [5, 5] for direction 7' do
        expect(game.direction([4, 3], 7)).to eq([5, 1])
      end

      it 'returns nil if outside of board' do
        expect(game.direction([0, 0], 0)).to be_nil
      end

      it 'returns nil if invalid input' do
        expect(game.direction([9, 9], 1)).to be_nil
      end
    end
  end
end
