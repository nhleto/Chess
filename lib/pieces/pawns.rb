# frozen_string_literal: true

require 'colorize'

# pawn clas
class Pawn
  attr_reader :color, :symbol, :name
  def initialize(color)
    @color = color
    @symbol = piece
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
    p moves.include?(to)
  end

  # def forwards_backwards?(from, to)
  #   p from, to
  #   p @color == :white && from[0] < to[0] ? false : true
  # end

  def on_board?(to)
    x, y = to
    ((0..7).include?(x) && (0..7).include?(y))
  end
end
