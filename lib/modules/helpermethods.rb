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

  def pieces_moved?
    pos = ''
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        pos = [x, y] if piece != '   ' && piece.class.name == 'Rook' && piece.color == current_player.color && piece.moved == false
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

  # decide if I want to take the other rook too (if i need it?) also, whether or not to have return t/f
  def can_castle?(from, to)
    rook = pieces_moved?
    king = friendly_king
    p rook, king
  end
end
