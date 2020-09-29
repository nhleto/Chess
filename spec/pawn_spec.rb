# frozen_string_literal: true

require '../lib/pieces/pawns.rb'
require '../lib/board.rb'
# require 'colorize'
# require '../lib/pieces/piece.rb'
# require './lib/modules/helpermethods'

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
    context 'checks to see if moved' do
      it 'flips moved from true ~> false' do
        from = [4, 0]
        to = [3, 0]
        piece = Pawn.new(:white)
        piece.starting_moves(from, to)
        expect(piece.moved).to be(true)
      end
    end
    context 'checks to see if moved' do
      it 'flips moved from true ~> false' do
        from = [6, 0]
        to = [6, 0]
        piece = Pawn.new(:white)
        piece.starting_moves(from, to)
        expect(piece.moved).to be(false)
      end
    end
  end
  describe '#capture_moves' do
    context 'when a pawn captures a piece' do
      it 'returns true' do
        board = Board.new
        from = [5, 0]
        to = [4, 1]
        board.game_board[4][1] = Pawn.new(:white)
        piece = Pawn.new(:white)

        piece.starting_moves(from, to)
        expect(piece.capture_moves(from, to)).to be(false)
      end
    end
  end
end
