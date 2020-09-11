# frozen_string_literal: true

class Rook
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2656 ".white : " \u265c ".black
  end

  def starting_moves(from, to)
    x, y = from
    moves = []
    8.times do |i|
      moves << [x - i, y]
      moves << [x + i, y]
      moves << [x, y + i]
      moves << [x, y - i]
    end
    moves.select! do |cell|
      cell[0].between?(0, 8) && cell[1].between?(0, 8)
    end
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to) && on_board?(to)
    p moves.include?(to) && on_board?(to)
  end

  # hopfully on_board? can become an integrated way to negate bad values
  def on_board?(to)
    x, y = to
    ((0..7).include?(x) && (0..7).include?(y))
  end
end
