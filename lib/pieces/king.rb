# frozen_string_literal: true

class King
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2654 ".white : " \u265A ".black
  end

  def starting_moves(from, to)
    x, y = from
    moves = []
    moves << [x + 1, y]
    moves << [x - 1, y]
    moves << [x, y + 1]
    moves << [x, y - 1]
    moves << [x + 1, y + 1]
    moves << [x -1, y - 1]
    check_moves?(to, moves)
  end

  def check_moves?(moves, to)
    moves.include?(to)
  end
end
