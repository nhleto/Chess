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

  def get_opponent_pieces
    pieces = []
    0.upto(7) do |i|
      0.upto(7) do |j|
        piece = board.game_board[i][j]
        pieces.push(board.game_board[i][j]) if board.game_board[i][j] != '   ' && piece.color != current_player.color
      end
    end
    pieces
  end

  def possible_opponent_moves(from)
    king_pos = king_position
    poss_moves = []
    opp_pieces = get_opponent_pieces
    opp_pieces.each do |piece|
      if piece.class != King && piece.class != Pawn # deciding if this returns pieces or just moves
        if legal_move?(from, king_pos, piece)
          poss_moves << piece.moves # want to check if is a legal move before passing to array
        end
      elsif piece.class == Pawn
        poss_moves << piece.all_pawn_moves(from) if legal_move?(from, king_pos, piece)
      end
    end
    poss_moves.uniq
  end

  # identifies piece that put king in check
  def checking_piece(from)
    king_pos = king_position
    p checking_moves = possible_opponent_moves(from)
    possible_check_moves = []
    checking_moves.each do |move|
      if legal_move
        possible_check_moves << move if check_king(king_pos, move)
      end
    end
    # p possible_check_moves
    # check_king(king_pos, checking_moves)
    # potentially running through legal move or making a method that takes the piece appropriately
  end

  # def legal_king_moves(from, from1, piece1)
  #   x, y = king_position
  #   king = board.game_board[x][y]
  #   possible_moves = king.moves
  #   opponent_moves = possible_opponent_moves(from)
  #   poss_moves = legal_possible_move(king_position, king, possible_moves)
  #   free_move = safe_poss_moves(from1, piece1)
  #   arr = []
  #   if !opponent_moves.include?(poss_moves)
  #     arr << poss_moves
  #   end
  #   filter = arr.filter { |move| !free_move.include?(move) }
  #   p filter
  # end

  # def safe_poss_moves(from1, piece1)
  #   moves = []
  #   piece1.moves.each do |move|
  #     if legal_move?(from1, move, piece1)
  #       moves << move
  #     end
  #   end
  #   moves
  # end

  # def legal_possible_move(king_position, king, possible_moves)
  #   potential_moves = []
  #   possible_moves.each do |move|
  #     if legal_move?(king_position, move, king)
  #       potential_moves << move
  #     end
  #   end
  #   potential_moves
  # end
end
