# frozen_string_literal: true

# pawn clas
class Pawn
  attr_reader :color
  def initialize
    @color = color
    @symbol = symbol
  end

  def piece
    @color == 'white' ? '♙' : '♟'
  end
end
