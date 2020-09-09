require 'colorize'
require 'pry'
require_relative './pieces/pawns'
require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/rook'
require_relative './modules/board_coords.rb'
require_relative './error.rb'
require_relative './game.rb'

# responsible for creating and maintaining board
class Board
  include BoardCoords

  attr_reader :game_board, :error, :game
  def initialize
    setup
    @error = Error.new
    @game = Game.new
  end

  def stage_move
    from = 'h7'
    to = 'h4'
    from_coord = BoardCoords.create_coord(from)
    to_coord = BoardCoords.create_coord(to)
    start_x, start_y = from_coord
    piece = game_board[start_x][start_y]
    valid_move?(from_coord, to_coord, piece)
  end

  def valid_move?(from_coord, to_coord, piece)
    case piece.name
    when 'Pawn'
      if piece.starting_moves(from_coord, to_coord)
        make_move(from, to)
      else
        error.pawn_movement
        game.move_to
      end
    end
  end

  def make_move(from, to)
    start_x, start_y = from
    to_x, to_y = to
    @game_board[to_x][to_y] = @game_board[start_x][start_y]
    @game_board[start_x][start_y] = '   '
  end

  def display_board
    board_copy = []
    @game_board.each { |cell| board_copy << cell.dup }
    paint_board(board_copy)
  end

  def paint_board(board)
    board.each_with_index do |row, row_index|
      row.each_with_index do |square, column_index|
        board[row_index][column_index] = if row_index.odd?
                                           if column_index.odd?
                                             paint_bg_1(square)
                                           else
                                             paint_bg_2(square)
                                           end
                                         else
                                           if column_index.odd?
                                             paint_bg_2(square)
                                           else
                                             paint_bg_1(square)
                                           end
                                              end
      end
    end
    put_board(board)
  end

  private

  def paint_bg_1(square)
    square == '   ' ? square.colorize(background: :blue) : square.symbol.colorize(background: :blue)
  end

  def paint_bg_2(square)
    square == '   ' ? square.colorize(background: :green) : square.symbol.colorize(background: :green)
  end

  def populate_array(board)
    8.times do |i|
      board[6][i] = Pawn.new(:white)
      board[1][i] = Pawn.new(:black)
    end
    board[7][0] = Rook.new(:white)
    board[7][7] = Rook.new(:white)
    board[0][0] = Rook.new(:black)
    board[0][7] = Rook.new(:black)

    board[7][1] = Knight.new(:white)
    board[7][6] = Knight.new(:white)
    board[0][1] = Knight.new(:black)
    board[0][6] = Knight.new(:black)

    board[7][2] = Bishop.new(:white)
    board[7][5] = Bishop.new(:white)
    board[0][2] = Bishop.new(:black)
    board[0][5] = Bishop.new(:black)

    board[7][3] = Queen.new(:white)
    board[7][4] = King.new(:white)
    board[0][3] = Queen.new(:black)
    board[0][4] = King.new(:black)
  end

  def put_board(board)
    coords = ['a ', 'b ', 'c ', 'd ', 'e ', 'f ', 'g ', 'h ']
    num_coords = %w[8 7 6 5 4 3 2 1]
    puts "\t  " + coords.join(' ')
    board.each_with_index do |col, index|
      puts ["\t", num_coords[index], *col].join('')
    end
    puts "\t  " + coords.join(' ')
    puts "\n\n"
  end

  def setup
    @game_board = Array.new(8) { Array.new(8, '   ') }
    populate_array(@game_board)
  end
end

chess = Board.new
chess.display_board
chess.stage_move
chess.display_board
