# frozen_string_literal: true

class Bishop
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2657 ".white : " \u2657 ".black
  end
end