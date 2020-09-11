# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class Knight < Piece
  attr_reader :symbol, :color
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2658 " : " \u265e ".black
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []
    moves.push(
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x + 1, y + 2],
      [x + 1, y - 2],
      [x - 2, y + 1],
      [x - 2, y - 1],
      [x - 1, y + 2],
      [x - 1, y - 2]
    )
    @moves.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to)
    p moves.include?(to)
  end
end
