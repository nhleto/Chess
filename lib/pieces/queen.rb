# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class Queen < Piece
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2655 ".white : " \u265B ".black
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []
    8.times do |i|
      @moves.push(
        [x + i, y],
        [x - i, y],
        [x, y - i],
        [x, y + i],
        [x + i, y + i],
        [x - i, y - i],
        [x - i, y + i],
        [x + i, y - i]
      )
      @moves.select! do |cell|
        cell[0].between?(0, 8) && cell[1].between?(0, 8)
      end
    end
    check_moves?(to, moves)
  end

  def check_moves?(to, moves)
    moves.uniq.include?(to)
  end
end
