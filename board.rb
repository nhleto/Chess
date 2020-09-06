# frozen_string_literal: true

# responsible for creating and maintaining board
class Board
  attr_accessor :game_board
  def initialize
    setup
  end

  def display_board
    black = "\u25A1"
    white = "\u25A0"
    game_board.each_with_index do |cell, index|
      if cell[index] % 2 == 0
        cell[index] = black
      else
        cell[index] = white
      end
    end
  end

  private

  def setup
    @game_board = Array.new(8) { Array.new(8, '.') }
  end
end

chess = Board.new
p chess.display_board
