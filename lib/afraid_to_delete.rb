  # def check_vertical_same?(from, piece)
  #   x, y = from
  #   adjacent_piece_up = board.game_board[x - 1][y]
  #   adjacent_piece_down = board.game_board[x] == board.game_board[7] ? '   ' : board.game_board[x + 1][y]
  #   # binding.pry
  #   if adjacent_piece_up == '   ' && adjacent_piece_down == '   ' || adjacent_piece_up == '   ' && adjacent_piece_down.color == piece.color || adjacent_piece_down == '   ' && adjacent_piece_up.color == piece.color
  #     true
  #   elsif adjacent_piece_up == '   ' && adjacent_piece_down.color != piece.color
  #     false
  #   elsif adjacent_piece_up.color != piece.color && adjacent_piece_down == '   '
  #     false
  #   elsif adjacent_piece_up.color == piece.color && adjacent_piece_down.color == piece.color
  #     true
  #   elsif adjacent_piece_up.color != piece.color && adjacent_piece_down.color != piece.color
  #     false
  #   elsif board.game_board[x] == board.game_board[0] && adjacent_piece_up.color != piece.color && adjacent_piece_down.color == piece.color
  #     true
  #   end
  # end

  # def adjacent_left_right_same?(from, piece)
  #   # p from
  #   x, y = from
  #   adjacent_piece_left = board.game_board[x][y - 1]
  #   adjacent_piece_right = board.game_board[y] == board.game_board[7] ? '   ' : board.game_board[x][y + 1]
  #   # binding.pry
  #   if adjacent_piece_left == '   ' && adjacent_piece_right == '   ' || adjacent_piece_right == '   ' && adjacent_piece_left.color == piece.color || adjacent_piece_left == '   ' && adjacent_piece_right.color == piece.color
  #     true
  #   elsif adjacent_piece_left == '   ' && adjacent_piece_right.color != piece.color
  #     false
  #   elsif adjacent_piece_left.color != piece.color && adjacent_piece_right == '   '
  #     false
  #   elsif adjacent_piece_left.color != piece.color && adjacent_piece_right.color == piece.color
  #     false
  #   elsif adjacent_piece_left.color == piece.color && adjacent_piece_right.color != piece.color
  #     false
  #   elsif adjacent_piece_left.color == piece.color && adjacent_piece_right.color == piece.color
  #     true
  #   elsif adjacent_piece_left.color != piece.color && adjacent_piece_right.color != piece.color
  #     false
  #   end
  # end