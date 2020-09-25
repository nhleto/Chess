# frozen_string_literal: true

require_relative './piece.rb'
require 'colorize'

class Rook < Piece
  attr_reader :color, :symbol, :moved
  def initialize(color)
    @color = color
    @symbol = piece
    @moved = false
    @last_move = []
    # super(last_move)
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

  def check_moves?(to)
    @moves.include?(to)
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end
end
