# frozen_string_literal: true

class Knight
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2658 " : " \u265e ".black
  end
end