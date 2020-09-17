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
    elsif @color == :white
      @moves << [x - 1, y]
      @moves << [x - 1, y - 1]
      @moves << [x - 1, y + 1]
    end

    if x == 1 && @color == :black
      @moves << [x + 1, y]
      @moves << [x + 2, y]
    elsif @color == :black
      @moves << [x + 1, y]
      @moves << [x + 1, y + 1]
      @moves << [x + 1, y - 1]
    end
    on_board_moves
  end

  def check_moves?(to)
    @moves.include?(to)
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end

  def capture_piece(from, to, board)
    i, j = to
    # x, y = from
    if board[i][j] != '   '
      destination = board[i][j]
      if destination.color != color
        parse_capture?(from, to, board)
      elsif destination.color == color
        false
      end
    elsif capture_moves(from, to)
      false
    else
      true
    end
  end

  def parse_capture?(from, to, board)
    x, y = from
    if board[x - 1][y] != color || board[x + 1][y] != color
      false
    else
      true
    end

    capture_moves(from, to)
  end

  # if a capture move takes an enemy piece / return true. else , return false
  def capture_moves(from, to)
    x, y = from
    capture_moves = []
    capture_moves << [x - 1, y + 1]
    capture_moves << [x - 1, y - 1]
    capture_moves << [x + 1, y + 1]
    capture_moves << [x + 1, y - 1]

    on_board_moves(capture_moves)

    capture_moves.include?(to) && to != color ? true : false
  end
end
