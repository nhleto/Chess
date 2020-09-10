# frozen_string_literal: true

require 'colorize'

# pawn clas
class Pawn
  attr_reader :color, :symbol, :name
  def initialize(color)
    @color = color
    @symbol = piece
    @name = 'Pawn'
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F ".white
  end

  def starting_moves(from, to)
    x, y = from
    moves = []
    if x == 6 && @color == :white
      moves << [x - 1, y]
      moves << [x - 2, y]
    else
      moves << [x - 1, y]
      moves << [x - 1, y - 1]
      moves << [x - 1, y + 1]
    end

    if x == 1 && @color == :black
      moves << [x + 1, y]
      moves << [x + 2, y]
    else
      moves << [x + 1, y]
      moves << [x + 1, y + 1]
      moves << [x + 1, y - 1]
    end
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to)
  end
end
