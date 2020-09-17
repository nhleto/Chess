# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class Bishop < Piece
  attr_reader :symbol, :color
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2657 ".white : " \u2657 ".black
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []
    8.times do |i|
      moves << [x - i, y + i]
      moves << [x + i, y - i]
      moves << [x + i, y + i]
      moves << [x - i, y - i]
    end
    on_board_moves
    check_moves?(moves, to)
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end

  def check_moves?(moves, to)
    moves.uniq.include?(to)
    p moves.include?(to)
  end
end
