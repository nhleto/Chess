# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class King < Piece
  attr_reader :symbol, :color
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? ' K ' : " K ".black
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []
    moves << [x + 1, y]
    moves << [x - 1, y]
    moves << [x, y + 1]
    moves << [x, y - 1]
    moves << [x + 1, y - 1]
    moves << [x - 1, y + 1]
    moves << [x + 1, y + 1]
    moves << [x - 1, y - 1]
    on_board_moves
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end

  def check_moves?(to)
    @moves.include?(to)
  end

  def check_moves
    
  end
end
