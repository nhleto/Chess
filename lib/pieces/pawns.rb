# frozen_string_literal: true

require 'colorize'
require_relative './piece.rb'

# pawn clas
class Pawn < Piece
  attr_reader :symbol, :color
  def initialize(color)
    @symbol = piece
    @color = color
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F ".white
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []
    if x == 6 && @color == :white
      @moves << [x - 1, y]
      @moves << [x - 2, y]
    else
      @moves << [x - 1, y]
      @moves << [x - 1, y - 1]
      @moves << [x - 1, y + 1]
    end

    if x == 1 && @color == :black
      @moves << [x + 1, y]
      @moves << [x + 2, y]
    else
      @moves << [x + 1, y]
      @moves << [x + 1, y + 1]
      @moves << [x + 1, y - 1]
    end
    @moves.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
    check_moves?(to)
  end

  def capture_piece(from, to, board)
    i, j = to
    if board[i][j] != '   '
      destination = board[i][j]
      if destination.color != color
        parse_capture(destination, to, board)
      elsif destination.color == color
        false
      end
    else
      true
    end
  end

  def parse_capture(from, to, destination, board)
    x, y = from
    if board[x - 1][y] != color
      false
    else
      true
    end
  end

  def check_moves?(to)
    @moves.include?(to)
    p @moves.include?(to)
  end
end
