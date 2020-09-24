# frozen_string_literal: true

# responsible for pawn promotion, en-passant, and castling
module HelperMethods
  def promote_pawn?(to, piece)
    if piece.class.name == 'Pawn'
      pawn_promotion(to, piece)
    end
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
end
