# frozen_string_literal: true

require 'colorize'
require_relative './piece.rb'
require_relative '../modules/helpermethods'

# pawn clas
class Pawn < Piece
  attr_reader :symbol, :color, :moved, :ep_move, :crossed_piece
  def initialize(color)
    @color = color
    @symbol = piece
    @moved = false
    @ep_move = nil
    @crossed_piece = []
    super(moves, last_move, moved)
  end

  def piece
    @color == :white ? " \u2659 " : " \u265F "
  end

  def starting_moves(from, to)
    x, y = from
    @moves = []

    if x == 6 && @moved == false
      moves << [x - 1, y]
      moves << [x - 2, y]
      moves << [x - 1, y + 1]
      moves << [x - 1, y - 1]
    elsif x == 1 && @moved == false
      moves << [x + 1, y]
      moves << [x + 2, y]
      moves << [x + 1, y + 1]
      moves << [x + 1, y - 1]
    elsif @color == :white && @moved == true
      moves << [x - 1, y]
      moves << [x - 1, y + 1]
      moves << [x - 1, y - 1]
    elsif @color == :black && @moved == true
      moves << [x + 1, y]
      moves << [x + 1, y + 1]
      moves << [x + 1, y - 1]
    end
    check_if_moved(to)
    check_if_double_step(from, to)
    on_board_moves
  end

  def check_if_double_step(from, to)
    last_move << from
    last_move << to
    last_move
  end

  def all_pawn_moves(from)
    x, y = from
    moves = []
    moves << [x - 1, y]
    moves << [x - 2, y]
    moves << [x + 1, y]
    moves << [x + 2, y]
    moves << [x - 1, y]
    moves << [x - 1, y + 1]
    moves << [x - 1, y - 1]
    moves << [x + 1, y]
    moves << [x + 1, y + 1]
    moves << [x + 1, y - 1]
    on_board_moves(moves)
    moves.uniq!
  end

  def check_if_moved(to)
    x, y = to
    if @color == :white && x != 6
      @moved = true
    elsif @color == :black && x != 1
      @moved = true
    end
  end

  def check_moves?(to)
    @moves.include?(to)
  end

  def on_board_moves(array = @moves)
    array.select! do |cell|
      cell[0].between?(0, 7) && cell[1].between?(0, 7)
    end
  end

  def capture_piece(from, to, board)
    i, j = to
    if board[i][j] != '   '
      destination = board[i][j]
      if destination.color != color
        parse_capture?(from, to, board)
      elsif destination.color == color
        false
      end
    elsif capture_moves(from, to)
      true
    else
      true
    end
  end

  def parse_capture?(from, to, board)
    x, y = from
    if board[x - 1][y] != color || board[x + 1][y] != color
      false
    else
      true
    end
    capture_moves(from, to)
  end

  # if a capture move takes an enemy piece / return true. else , return false
  def capture_moves(from, to)
    # p from, to
    x, y = from
    i, j = to
    capture_moves = []
    capture_moves << [i + 1, j - 1]
    capture_moves << [i - 1, j + 1]
    capture_moves << [x - 1, y + 1]
    capture_moves << [x - 1, y - 1]
    capture_moves << [x + 1, y + 1]
    capture_moves << [x + 1, y - 1]

    on_board_moves(capture_moves)
    capture_moves.include?(to) && to != color ? true : false
  end

  def en_passant(from, to, board)
    x, y = from
    row = color == :white ? 4 : 3

    return false unless x == row

    right_cell_occupied = parse_side_piece_right?(to, board)
    left_cell_occupied = parse_side_piece_left?(to, board)

    moves = push_ep_moves(to, board) if right_cell_occupied
    moves = push_ep_moves(to, board) if left_cell_occupied
    @ep_move = moves
    @moves << moves
  end

  def parse_side_piece_right?(to, board)
    i, j = to
    piece = board[i][j + 1]
    board[i][j + 1] != '   ' && piece.color != color && piece.class.name == 'Pawn' ? true : false
  end

  def parse_side_piece_left?(to, board)
    i, j = to
    piece = board[i][j - 1]
    board[i][j - 1] != '   ' && piece.color != color && piece.class.name == 'Pawn' ? true : false
  end

  def push_ep_moves(to, board)
    i, j = to
    offset = @color == :white ? 1 : -1
    piece = board[i][j + offset]
    if board[i][j + offset] != '   ' && piece.color != color && piece.class.name == 'Pawn' && parse_last_moves(piece) == 2
      if piece.color == :black
        move = split_move_difference(piece, board)
      elsif piece.color == :white
        move = split_move_difference(piece, board)
      end
    end
    move
  end

  def toggle_ep(to, board)
    # white / black ep move works on far right side of board. middle / left ep doesnt work : crossed piece == [] && ep_move == nil
    return unless to == @ep_move

    board[@crossed_piece[0]][@crossed_piece[1]] = '   '
  end

  def parse_last_moves(piece)
    offset = piece.last_move[0][0] - piece.last_move[1][0]
    offset.abs
  end

  def split_move_difference(piece, board)
    move = []
    @crossed_piece = address(board, piece)
    if piece.color == :black
      move << piece.last_move[1][0] - piece.last_move[0][0]
      move << piece.last_move[0][1]
    elsif piece.color == :white
      move << (piece.last_move[1][0] + piece.last_move[0][0]) / 2
      move << piece.last_move[0][1]
    end
    move
  end

  def address(board, input)
    board.each_with_index do |subarray, i|
      j = subarray.index(input)
      return i, j if j
    end
    nil
  end
end
