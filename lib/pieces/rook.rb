# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class Rook < Piece
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
    @moves = []
    8.times do |i|
      moves << [x - i, y]
      moves << [x + i, y]
      moves << [x, y + i]
      moves << [x, y - i]
    end
    on_board_moves
    check_moves?(moves, to)
  end

  def check_moves?(moves, to)
    moves.include?(to) && on_board?(to)
    p moves.include?(to) && on_board?(to)
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end
end
