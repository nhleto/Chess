require 'colorize'
require_relative './pawns'
require_relative './king'
require_relative './queen'
require_relative './knight'
require_relative './bishop'
require_relative './rook'

# responsible for creating and maintaining board

# responsible for handling board cues
class Board
  attr_reader :game_board
  def initialize
    setup
  end

  def populate_board
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
    coords = [' a ', 'b ', 'c ', 'd ', 'e ', 'f ', 'g ', 'h ']
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
  end
end

chess = Board.new
chess.populate_board
chess.display_board
