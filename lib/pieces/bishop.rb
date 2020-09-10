# frozen_string_literal: true

class Bishop
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2657 ".white : " \u2657 ".black
  end

  def starting_moves(from, to)
    x, y = from
    moves = []
    8.times do |i|
      moves << [x - i, y + i]
      moves << [x + i, y - i]
      moves << [x + i, y + i]
      moves << [x - i, y - i]
    end
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to)
    p moves.include?(to)
  end
end
