# frozen_string_literal: true

# super piece class
class Piece
  attr_accessor :moves, :last_move
  def initialize(moves, last_move, moved)
    @moves = moves
    @last_move = []
    @moved = false
  end

  def name
    name
  end

  def a_piece?
    name != String
  end
end
