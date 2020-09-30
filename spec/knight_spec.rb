# frozen_string_literal: true

require '../lib/pieces/knight.rb'
require '../lib/board.rb'

describe Knight do
  let(:wk) { Knight.new(:white) }
  let(:bk) { Knight.new(:black) }
  describe '#init' do
    context 'when knights spawn' do
      it 'has unique symbol' do
        expect(wk.symbol).to eq(" \u2658 ")
        expect(bk.symbol).to eq(" \u265e ".black)
      end
    end
  end
  describe '#validate_knight' do
    let(:board) { Board.new }
    context 'when knight moved to unoccupied square' do
      it 'returns true' do
        to = [5, 0]
        expect(wk.validate_knight?(to, board.game_board)).to be(true)
      end
    end
    context 'when knight moved to friendly occupied square' do
      it 'returns false' do
        to = [6, 0]
        expect(wk.validate_knight?(to, board.game_board)).to be(false)
      end
    end
  end
end
