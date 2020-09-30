# frozen_string_literal: true

require '../lib/pieces/queen.rb'

describe Queen do
  let(:white_queen) { Queen.new(:white) }
  let(:black_queen) { Queen.new(:black) }
  describe '#init' do
    context 'when new queens spawned' do
      it 'has unicode symbol' do
        expect(white_queen.symbol).to eq(" \u2655 ".white)
        expect(black_queen.symbol).to eq(" \u265B ".black)
      end
    end
  end
end
