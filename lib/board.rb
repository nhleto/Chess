require 'colorize'
require_relative './pieces/pawns'
require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/rook'
require_relative './modules/board_coords.rb'

# responsible for creating and maintaining board
class Board
  include BoardCoords

  attr_reader :game_board
  def initialize
    setup
  end

  # TODO: Add in FROM and TO movement co-ords
  def move_piece(from, to)
    from_coord = BoardCoords.create_coord(from)
    to_coord = BoardCoords.create_coord(to)
    p from_coord
    p to_coord
    # display_board
  end

  def populate_array
    8.times do |i|
      @game_board[6][i] = Pawn.new(:white).symbol
      @game_board[1][i] = Pawn.new(:black).symbol
    end
    @game_board[7][0] = Rook.new(:white).symbol
    @game_board[7][7] = Rook.new(:white).symbol
    @game_board[0][0] = Rook.new(:black).symbol
    @game_board[0][7] = Rook.new(:black).symbol

    @game_board[7][1] = Knight.new(:white).symbol
    @game_board[7][6] = Knight.new(:white).symbol
    @game_board[0][1] = Knight.new(:black).symbol
    @game_board[0][6] = Knight.new(:black).symbol

    @game_board[7][2] = Bishop.new(:white).symbol
    @game_board[7][5] = Bishop.new(:white).symbol
    @game_board[0][2] = Bishop.new(:black).symbol
    @game_board[0][5] = Bishop.new(:black).symbol

    @game_board[7][3] = Queen.new(:white).symbol
    @game_board[7][4] = King.new(:white).symbol
    @game_board[0][3] = Queen.new(:black).symbol
    @game_board[0][4] = King.new(:black).symbol
  end

  def display_board
    game_board.each_with_index do |row, row_index|
      row.each_with_index do |square, column_index|
        game_board[row_index][column_index] = if row_index.odd?
                                                if column_index.odd?
                                                  square.colorize(background: :blue)
                                                else
                                                  square.colorize(background: :green)
                                                end
                                              else
                                                if column_index.odd?
                                                  square.colorize(background: :green)
                                                else
                                                  square.colorize(background: :blue)
                                                end
                                              end
      end
    end
    put_board
  end

  def put_board
    coords = ['a ', 'b ', 'c ', 'd ', 'e ', 'f ', 'g ', 'h ']
    num_coords = %w[8 7 6 5 4 3 2 1]
    puts "\t  " + coords.join(' ')
    @game_board.each_with_index do |col, index|
      puts ["\t", num_coords[index], *col].join('')
    end
    puts "\t  " + coords.join(' ')
    puts "\n\n"
  end

  def setup
    @game_board = Array.new(8) { Array.new(8, '   ') }
    populate_array
  end
end

# chess = Board.new
# chess.display_board
# chess.map_board
