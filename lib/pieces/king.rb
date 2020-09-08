# frozen_string_literal: true

class King
  attr_reader :color, :symbol
  def initialize(color)
    @color = color
    @symbol = piece
  end

  def piece
    @color == :white ? " \u2654 ".white : " \u265A ".black
  end
end