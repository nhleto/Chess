# frozen_string_literal: true

require 'colorize'
require_relative './pawns'
require_relative './king'
require_relative './queen'
require_relative './knight'
require_relative './bishop'
require_relative './rook'

# responsible for creating and maintaining board
class Board
  attr_accessor :game_board
  def initialize
    setup
  end

  def display_board
    black = '  '.colorize(background: :black)
    white = '  '.colorize(background: :white)
    game_board.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        game_board[i][j] = ((i + j) % 2).zero? ? white : black
      end
    end
    put_board
  end

  def populate_board
    game_board[1][1] = Pawn.new
  end

  private

  def put_board
    coords = %w[a b c d e f g h]
    num_coords = %w[8 7 6 5 4 3 2 1]
    puts "\t  " + coords.join(' ')
    puts "\t  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ "
    game_board.each_with_index do |col, index|
      puts ["\t", num_coords[index], '|', *col, '|'].join('')
    end
    puts "\t  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
    puts "\t  " + coords.join(' ')
    puts "\n\n"
  end

  def setup
    @game_board = Array.new(8) { Array.new(8, '  ') }
  end
end

chess = Board.new
chess.populate_board
chess.display_board
