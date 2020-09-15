# frozen_string_literal: true

class Piece
  attr_accessor :moves
  def initialize
    @moves = moves
  end

  def name
    name
  end

  def a_piece?
    name != String
  end
end
