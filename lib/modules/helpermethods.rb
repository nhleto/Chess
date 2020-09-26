# frozen_string_literal: true

# responsible for pawn promotion, and castling
module HelperMethods
  def promote_pawn?(to, piece)
    pawn_promotion(to, piece) if piece.class.name == 'Pawn'
  end

  def pawn_promotion_possible?(to, piece)
    i, j = to
    if piece.color == :white && i.zero?
      pawn_promotion(to, piece)
    elsif piece.color == :black && i == 7
      pawn_promotion(to, piece)
    end
  end

  def pawn_promotion(to, piece)
    i, j = to
    options = [Queen, Bishop, Rook, Knight, Pawn]
    if piece.color == :white && i.zero?
      pawn_promotion_message(options)
      choose_piece(to)
    elsif piece.color == :black && i == 7
      pawn_promotion_message(options)
      choose_piece(to)
    end
  end

  def pawn_promotion_message(options)
    puts "\nYour pawn has promoted, which piece would you like it to become? The options are".green + " #{options}".yellow
  end

  def choose_piece(to)
    input = gets.chomp
    i, j = to
    case valid_input?(input, to)
    when 1
      board.game_board[i][j] = Queen.new(current_player.color)
    when 2
      board.game_board[i][j] = Bishop.new(current_player.color)
    when 3
      board.game_board[i][j] = Rook.new(current_player.color)
    when 4
      board.game_board[i][j] = Knight.new(current_player.color)
    when 5
      board.game_board[i][j] = Bishop.new(current_player.color)
    end
  end

  def valid_input?(input, to)
    if input.match?(/^[1-5]{1}/)
      input.to_i
    else
      puts "\nPlease enter valid input..."
      choose_piece(to)
    end
  end

  def rook_position
    pos = []
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        if piece != '   ' && piece.class.name == 'Rook' && piece.color == current_player.color && piece.moved == false
          pos << [x, y]
        elsif piece != '   ' && piece.class.name == 'Rook' && piece.color == current_player.color && piece.moved == false
          pos << [x, y]
        end
      end
    end
    pos
  end

  def friendly_king
    pos = ''
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        pos = [x, y] if piece != '   ' && piece.class.name == 'King' && piece.color == current_player.color
      end
    end
    pos
  end

  def space_between_r_k(king_pos, rook_pos)
    return false if rook_pos.is_a?(String) || king_pos.is_a?(String)

    space = []
    row = king_pos[0]
    if rook_pos.length == 1
      min1 = (rook_pos[0][1] == 7 ? king_pos[1] : rook_pos[0][1]) + 1
      max1 = (rook_pos[0][1] == 7 ? rook_pos[0][1] : king_pos[1]) - 1
      min1.upto(max1) { |col| space.push([row, col]) }
    # queenside spaces
    elsif rook_pos.length > 1
      min1 = (rook_pos[0][1] == 7 ? king_pos[1] : rook_pos[0][1]) + 1
      max1 = (rook_pos[0][1] == 7 ? rook_pos[0][1] : king_pos[1]) - 1
      min = (rook_pos[1][1] == 7 ? king_pos[1] : rook_pos[1][1]) + 1
      max = (rook_pos[1][1] == 7 ? rook_pos[1][1] : king_pos[1]) - 1
      min.upto(max) { |col| space.push([row, col]) }
      min1.upto(max1) { |col| space.push([row, col]) }
    end
    p space
  end

  def between_squares_valid?(squares)
    return false unless squares

    # p squares
    if squares.length == 2
      king_side = squares[0, 1] + squares[1, 1]
      valid_move_king_side = king_side.map { |cell| board.game_board[cell[0]][cell[1]] == '   ' }
      valid_move_king_side.all? { |cell| cell == true } # this line is not returning t/f
    elsif squares.length > 2
      # king_side = squares[0, 1] + squares[1, 1] # I dont think this even fits in here / why need to check queen and king at same time
      p queenside = squares[2, 2] + squares[4, 4]
      valid_move_queen_side = queenside.map { |cell| board.game_board[cell[0]][cell[1]] == '   ' }
      valid_move_queen_side.all? { |cell| cell == true }
    end
  end

  # this method seems to be placing moves in their regarless of whether or not [between_sqaures_valid] returns t / f
  def get_castle_moves(rook_pos, king_pos)
    moves = []
    rook_pos
    row = king_pos[0]
    col = rook_pos[1][1] == 7 ? 6 : 2
    king = board.game_board[king_pos[0]][king_pos[1]]
    king.moves.push([row, col])
  end

  def can_castle?
    rook_pos = rook_position
    king_pos = friendly_king
    squares = space_between_r_k(king_pos, rook_pos)
    p middle_squares = between_squares_valid?(squares) # weird ouput
    get_castle_moves(rook_pos, king_pos) if middle_squares # moves are being pushed because this isn't returning t / f ??
  end
end
