# frozen_string_literal: true

require '../lib/pieces/pawns.rb'

describe Pawn do
  subject(:pawn) { described_class.new }
  let(:piece) { instance_double(Piece) }
  describe '#initialize' do
    context 'when new white pawn instantiated' do
      it 'places white piece' do
        pawn = Pawn.new(:white)
        expect(pawn.symbol).to be(" \u2659 ")
      end
    end
  end
  describe '#check_if_moved' do
    let(:piece) { Pawn.new(:white) }
    context 'checks to see if moved' do
      it 'flips moved from true ~> false' do
        from = [4, 0]
        to = [3, 0]
        piece.starting_moves(from, to)
        expect(piece.moved).to be(true)
      end
    end
    context 'checks to see if moved' do
      it 'flips moved from true ~> false' do
        from = [6, 0]
        to = [6, 0]
        piece.starting_moves(from, to)
        expect(piece.moved).to be(false)
      end
    end
  end
  describe '#en_passant' do
    let(:white_pawn) { Pawn.new(:white) }
    let(:black_pawn) { Pawn.new(:black) }
    let(:board) { Board.new }
    context 'checks if en_passant move is possible' do
      it 'can move to the spot' do
        from = [6, 0]
        to = [4, 0]
        white_pawn.starting_moves(from, to)
        from = [4, 0]
        to = [3, 0]
        white_pawn.starting_moves(from, to)
        expect(white_pawn.starting_moves(from, to)).to include([3, 1])
      end
    end
  end
end
