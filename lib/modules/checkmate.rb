# frozen_string_literal: true

# checkmate responsibilities
module Checkmate
  def potential_blockers(_piece1, from1, all_possible_moves)
    king_pos = king_position
    btwn_squares = between_squares(king_pos, from1)
    blockers = btwn_squares&.select { |move| all_possible_moves.include?(move) }
    blockers ? blockers.flatten : []
  end

  def block_check?(piece1, from1, all_possible_moves)
    # special_piece = [Rook, Bishop, Queen].include?(piece1.class)
    blockers = potential_blockers(piece1, from1, all_possible_moves)
    blockers.length.positive? ? true : false
  end

  def between_squares(_piece1, from1)
    king_pos = king_position
    btwn_squares = if king_pos[0] == from1[0]
                     horiz_between_squares(king_pos, from1)
                   elsif king_pos[1] == from1[1]
                     vertical_between_squares(king_pos, from1)
                   else
                     diag_between_squares(king_pos, from1)
    end
    btwn_squares
  end

  def diag_between_squares(king_pos, from1)
    # p "the king is at #{king_pos}"
    moves = []
    row, col = Vector.create_direction_vector(king_pos, from1)
    shift = (king_pos[0] - from1[0]).abs
    1.upto(shift) do |i|
      moves.push([king_pos[0] + (row * i), king_pos[1] + (col * i)])
    end
    moves
  end

  def vertical_between_squares(king_pos, from1)
    moves = []
    if king_pos[0] > from1[0]
      min = from1[0] + 1
      max = king_pos[0] - 1
    else
      min = king_pos[0] + 1
      max = from1[0] - 1
    end
    min.upto(max) { |i| moves.push([i, king_pos[1]]) }
    moves
  end

  def horiz_between_squares(king_pos, from1)
    moves = []
    if king_pos[1] > from1[1]
      min = from1[1] + 1
      max = king_pos[1] - 1
    else
      min = king_pos[1] + 1
      max = from1[1] - 1
    end
    min.upto(max) { |i| moves.push([king_pos[0], i]) }
    moves
  end

  def can_take_piece?(all_possible_moves, from1)
    all_possible_moves.include?(from1) ? true : false
  end

  def get_opponent_pieces(board)
    pieces = []
    0.upto(7) do |i|
      0.upto(7) do |j|
        piece = board[i][j]
        pieces.push(board[i][j]) if board[i][j] != '   ' && piece.color != current_player.color
      end
    end
    pieces
  end

  def possible_opponent_moves
    poss_moves = []
    opp_pieces = get_opponent_pieces(board)
    opp_pieces.each do |piece|
      if piece.class != King && piece.class != Pawn
        poss_moves += piece.moves
      elsif piece.class == Pawn
        poss_moves += piece.all_pawn_moves
      end
    end
    poss_moves.uniq
  end
end
