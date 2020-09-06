# frozen_string_literal: true

require 'colorize'

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
    puts "\t a b c d e f g h"
    puts "\t ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ "
    game_board.each do |col|
      puts "\t▕#{col.first}" + "#{col[1]}" + "#{col[2]}" + "#{col[3]}" + "#{col[4]}" + "#{col[5]}" + "#{col[6]}" + "#{col.last}▏" 
    end
    puts "\t ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
    puts "\t a b c d e f g h"
    puts "\n\n"
  end

  private

  def setup
    @game_board = Array.new(8) { Array.new(8, '  ') }
  end
end

chess = Board.new
chess.display_board
