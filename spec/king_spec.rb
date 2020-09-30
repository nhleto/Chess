# frozen_string_literal: true

require '../lib/pieces/king.rb'

describe King do
  let(:white_king) { King.new(:white) }
  let(:black_king) { King.new(:black) }
  describe '#init' do
    context 'when kings spawn' do
      it 'has unique symbol' do
        expect(white_king.symbol).to be(" \u2655 ")
        expect(black_king.symbol).to eq(" \u265a ".black)
      end
    end
  end
  describe '#check_if_moved' do
    context 'checks to see if moved' do
      it 'flips moved from false ~> true' do
        from = [4, 0]
        to = [3, 0]
        white_king.starting_moves(from, to)
        expect(white_king.moved).to be(true)
      end
    end
  end
end
