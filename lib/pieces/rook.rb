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
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to)
    p moves.include?(to)
  end

  def piece_in_the_way?
    
  end
end