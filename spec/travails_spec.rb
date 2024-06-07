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

  describe '#add_all_directions' do
    let(:recorder) { {} }
    context 'when knight on right top corner of board [0, 0]' do

      let(:directions) { game.add_all_directions([0, 0], recorder) }

      it 'has only 2 valid directions' do
        expect(directions.length).to eq(2)
      end

      it 'returns true for [2, 1]' do
        adjacent = directions.any? { |i| i[0].eql?([2, 1]) }
        expect(adjacent).to be true
      end

      it 'returns false for [1, 1]' do
        adjacent = directions.any? { |i| i[0].eql?([1, 1]) }
        expect(adjacent).to be false
      end

      it "stores knight's coordinate at second place" do
        expect(directions[0][1]).to eq([0, 0])
      end

      it "does not store knight's coordinate at first place" do
        expect(directions[0][0]).not_to eq([0, 0])
      end
    end

    context 'when knight on middle of board [4, 4]' do

      let(:directions) { game.add_all_directions([4, 4], recorder) }

      it 'has 8 valid directions' do
        expect(directions.length).to eq(8)
      end

      it 'returns true for [6, 5]' do
        adjacent = directions.any? { |i| i[0].eql?([6, 5]) }
        expect(adjacent).to be true
      end

      it 'returns false for [4, 5]' do
        adjacent = directions.any? { |i| i[0].eql?([4, 5]) }
        expect(adjacent).to be false
      end

      it "stores knight's coordinate at second place" do
        expect(directions[0][1]).to eq([4, 4])
      end

      it "does not store knight's coordinate at first place" do
        expect(directions[0][0]).not_to eq([4, 4])
      end
    end
  end
end