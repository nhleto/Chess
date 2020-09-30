# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class King < Piece
  attr_reader :symbol, :color, :moves, :moved, :last_move
  def initialize(color)
    @color = color
    @symbol = piece
    @last_move = []
    @moved = false
  end

  def piece
    @color == :white ? " \u2655 " : " \u265a ".black
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
    check_if_last_move(to)
    check_if_moved
    on_board_moves
  end

  def check_if_last_move(to)
    @last_move << to
    @last_move.filter! { |move| !move.nil? }
  end

  def check_if_moved
    @moved = true if @last_move.flatten.length > 1
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end

  def check_moves?(to)
    @moves.include?(to)
  end
end
