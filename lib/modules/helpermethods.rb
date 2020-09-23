# frozen_string_literal: true

# responsible for pawn promotion, en-passant, and castling
module HelperMethods
  def pawn_promotion(from, to, piece)
    x, y = from
    i, j = to
    options = [Queen, Bishop, Rook, Knight, Pawn]
    if piece.color == :white && board.game_board[i].zero?
      pawn_promotion_message(options)
      choose_piece(options, piece, from)
    elsif piece.color == :black && i == 7
      pawn_promotion_message(options)
      choose_piece(options, piece, from)
    end
  end

  def pawn_promotion_message(options)
    puts "\nYour pawn has promoted, which piece would you like it to become? The options are".green + " #{options}".yellow
  end

  def choose_piece(_options, _piece, from)
    input = gets.chomp.to_i
    if input.zero?
      x, y = from
      p board.game_board[x][y] = Queen.new(current_player.color)
      # piece = Queen.new(current_player.color)
    end
  end
end
