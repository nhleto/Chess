# frozen_string_literal: true

require '../lib/pieces/bishop.rb'

describe Bishop do
  let(:wb) { Bishop.new(:white) }
  let(:bb) { Bishop.new(:black) }
  describe '#init' do
    context 'when bishops spawn' do
      it 'has unique symbol' do
        expect(wb.symbol).to eq(" \u2657 ".white)
        expect(bb.symbol).to eq(" \u2657 ".black)
      end
    end
  end
end
