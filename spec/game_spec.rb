# frozen_string_literal: true

require '../lib/game.rb'
require '../lib/board.rb'
# include 'colorize'

describe Game do
  subject(:game) { described_class.new }
  let(:error) { instance_double(Error) }
  describe 'initialization' do
    context 'when game begins' do
      it 'creates a new board instance' do
        expect(game.board).to be_instance_of(Board)
      end
      it 'creates a new player struct' do
        # Assert
        expect(game.player2.color).to be(:black)
      end
      it 'creates a new player struct' do
        # Assert
        expect(game.player1.color).to be(:white)
      end
    end
  end
  describe '#check_if_piece_in_way' do
    context 'if friendly piece is in the way' do
      it 'returns false' do
        from = [7, 0]
        to = [5, 0]
        piece = Pawn.new(:white)
        expect(game.check_if_piece_in_way?(from, to, piece)).to be(true)
      end
    end
    context 'when the way is clear' do
      it 'returns true' do
        from = [6, 0]
        to = [4, 0]
        piece = Pawn.new(:white)
        expect(game.check_if_piece_in_way?(from, to, piece)).to be(true)
      end
    end
  end
  describe '#piece.check_moves' do
    context 'if piece.move includes [to]' do
      it 'returns true' do
        to = [4, 0]
        from = [6, 0]
        piece = Pawn.new(:white)
        piece.starting_moves(from, to)
        expect(piece.check_moves?(to)).to be(true)
      end
    end
    context 'if piece.move !include [to]' do
      it 'returns false' do
        to = [3, 0]
        from = [6, 0]
        piece = Pawn.new(:white)
        piece.starting_moves(from, to)
        expect(piece.check_moves?(to)).to be(false)
      end
    end
  end
  describe '#parse_diag_value' do
    context 'if piece runs into teamate' do
      it 'returns false' do
        piece = Rook.new(:white)
        diag_val = Pawn.new(:white)
        expect(game.parse_diag_value(piece, diag_val)).to be(false)
      end
    end
    context 'if piece runs into teamate' do
      it 'returns false' do
        piece = Rook.new(:white)
        diag_val = Pawn.new(:black)
        expect(game.parse_diag_value(piece, diag_val)).to be(true)
      end
    end
  end
  describe '#double_check?' do
    context 'when friendly king is put in check by enemy piece (non-pawn)' do
      it 'returns true' do
        from = [3, 4]
        to = [5, 4]
        piece = Queen.new(:black)
        game.valid_piece_move?(from, to, piece)
        expect(game.valid_piece_move?(from, to, piece)).to be(true)
      end
    end
  end
  describe '#pawn_check?'
  context 'when friendly king is put in check by enemy pawn' do
    it 'returns true' do
      from = [4, 3]
      to = [5, 4]
      piece = Pawn.new(:black)
      game.valid_piece_move?(from, to, piece)
      expect(game.valid_piece_move?(from, to, piece)).to be(true)
    end
  end
end
