# frozen_string_literal: true

require 'colorize'

# pawn clas
class Pawn
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F ".white
  end
end
