# frozen_string_literal: true

require '../lib/pieces/rook.rb'

describe Rook do
  let(:wr) { Rook.new(:white) }
  let(:br) { Rook.new(:black) }
  describe '#init' do
    context 'when rooks spawn' do
      it 'has unique symbol' do
        expect(wr.symbol).to eq(" \u2656 ".white)
        expect(br.symbol).to eq(" \u265c ".black)
      end
    end
  end
  describe '#check_if_moved' do
    context 'when a piece is moved' do
      it 'moved = true' do
        from = [7, 0]
        to = [5, 0]
        wr.last_move << [4, 0]
        wr.check_if_moved
        expect(wr.moved).to be(true)
      end
    end
    context 'when a piece isnt moved' do
      it 'moved = false' do
        wr.check_if_moved
        expect(wr.moved).to be(false)
      end
    end
  end
end
