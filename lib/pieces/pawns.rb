# frozen_string_literal: true

require 'colorize'
# require_relative './lib/board.rb'

# pawn clas
class Pawn
  attr_reader :color, :symbol, :piece_type
  def initialize(color = :white)
    @color = color
    @symbol = piece
    @piece_type = 'pawn'
  end

  def class_name
    self.class
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F ".white
  end

  def starting_moves(from)
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
  end
end

# p = Pawn.new
# p.class_name