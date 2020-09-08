# frozen_string_literal: true

class Queen
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2655 ".white : " \u265B ".black
  end
end