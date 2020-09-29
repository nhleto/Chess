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

  def validate_knight?(to, board)
    i, j = to
    if board[i][j] != '   '
      destination = board[i][j]
      if destination.color != color
        true
      elsif destination.color == color
        false
      end
    else
      true
    end
  end
end
