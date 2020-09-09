# frozen_string_literal: true

require 'colorize'
# require_relative '../board.rb'

# pawn clas
class Pawn
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F ".white
  end

  def starting_moves(from, to)
    # p from
    # p to
    i, j = to
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
    check_moves?(moves, from, to)
  end

  def check_moves?(moves, from, to)
    p moves
    p from
    p to
    p moves.include?(to)
  end
end

# p = Pawn.new
# p.class_name
