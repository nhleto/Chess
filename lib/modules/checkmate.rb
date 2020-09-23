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

  def legal_king_moves(from, to = nil)
    x, y = king_position
    king = board.game_board[x][y]
    king.starting_moves(from, to)
    possible_moves = king.moves
    poss_moves = legal_possible_move(king_position, king, possible_moves)
    check_moves(poss_moves)
  end

  def check_moves(poss_moves)
    king_position1 = king_position
    reject_moves = []
    safe_moves = []
    poss_moves.each do |move|
      board.move_it(king_position, move) unless board.game_board
      if check?
        reject_moves << move
        # board.to_nil(king_position, move)
      elsif !check?
        safe_moves << move
      end
    end
    puts "safe moves are #{safe_moves}"
    puts "shit moves are #{reject_moves}"
    board.make_move(king_position, king_position1)
    if safe_moves.length.zero? # this keeps breaking the game!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      @safe_moves = 0
      true
    else
      false
    end
  end

  def legal_possible_move(king_position, king, possible_moves)
    # p "legal opponent moves are #{legal_opponent_moves}"
    potential_moves = []
    possible_moves.each do |move|
      if legal_move?(king_position, move, king)
        potential_moves << move
      end
    end
    potential_moves
  end
end
