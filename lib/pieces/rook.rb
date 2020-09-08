# frozen_string_literal: true

class Rook
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2656 ".white : " \u265c ".black
  end
end