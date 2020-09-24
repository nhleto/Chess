# frozen_string_literal: true

require 'colorize'
require_relative './piece.rb'

# pawn clas
class Pawn < Piece
  attr_reader :symbol, :color, :moved
  def initialize(color)
    @symbol = piece
    @color = color
    @moved = false
    super(moves, last_move)
  end

  def piece
    @color == :white ? ' P ' : " \u265F "
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
    check_if_moved(from)
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

  def check_if_moved(from)
    x, y = from
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
      false
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
    x, y = from
    capture_moves = []
    capture_moves << [x - 1, y + 1]
    capture_moves << [x - 1, y - 1]
    capture_moves << [x + 1, y + 1]
    capture_moves << [x + 1, y - 1]

    on_board_moves(capture_moves)

    capture_moves.include?(to) && to != color ? true : false
  end

  def en_passant(from, board)
    x, y = from
    row = color == :white ? 4 : 3
    possible = false

    # return false unless x == row

    p white_piece_possible = parse_side_piece?(from, board)
    p black_piece_possible = parse_side_piece?(from, board)
  end

  def parse_side_piece?(from, board)
    x, y = from
    if board[x][y + 1] != '   ' && piece.color != color && piece.class.name == 'Pawn'
      true
    elsif board[x][y - 1] != '   ' && piece.color != color && piece.class.name == 'Pawn'
      true
    else
      false
    end
  end

  def check_side_square(from, board)
    x, y = from
    p last_move[0][0], last_move[1]
    offset = color == :white ? 1 : -1

    if color == :white && x == 4
    #   if board[x][y + 1] != '   ' && piece.color != color && piece.class.name == 'Pawn' 
    #     puts 'bboys, we got em'.green
    #   end
    # elsif color == :black && x == 3
      # if board[x][y - 1] != '   ' && piece.color != color && piece.class.name == 'Pawn'
      #   puts 'bboys, we got em'.green
      # end
    end
  end
end
