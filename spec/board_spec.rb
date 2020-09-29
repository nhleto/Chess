# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }
  describe '#game_board' do
    context 'when game begins' do
      it 'has 8 rows' do
        expect(board.game_board.length).to be(8)
      end
      it 'has 8 cells in each row' do
        cells = []

        board.game_board.each do |row|
          row.each do |cell|
            cells << cell
          end
        end

        expect(cells.length).to be(64)
      end
    end
  end
  describe '#make_move' do
    context 'when move is passed to board' do
      it 'marks board appropriately' do
        from = [6, 0]
        to = [5, 0]
        board.make_move(from, to)
        expect(board.game_board[5][0].class.name).to eq('Pawn')
      end
    end
  end
end
