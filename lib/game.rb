# frozen_string_literal: true

require_relative './board'
require_relative './error'
require 'pry'

# game class is responsbile for game loop and game logic
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to, :error
  def initialize
    @player1 = Player.new('Henry', 'white')
    @player2 = Player.new('Sarah', 'black')
    @board = Board.new
    @error = Error.new
    @current_player = nil
    @answer = nil
    @from = nil
    @to = nil
  end

  # TODO: create set_players and intro_text
  def start_game
    # set_players
    # intro_text
    play_game
  end

  def play_game
    attempts = 0
    while attempts < 1
      board.display_board
      puts 'Make a move'
      set_move
      board.display_board
      attempts += 1
    end
  end

  def set_move
    puts "\nPlease give the co-ordinates of the piece you are moving"
    move_from
    # board.get_active_piece(from)
    start_move = board.input_to_coords(from)
    puts 'And where are you moving the piece to?'
    move_to
    end_move = board.input_to_coords(to)
    vet_piece_move?(start_move, end_move)
    # piece_move_real?(start_move, end_move)
  end

  # Have this method return a boolean and eventually chain it together with piece_move_real?
  def vet_piece_move?(from, to)
    piece = board.get_active_piece(from)
    piece.starting_moves(from, to)
    p piece
  end

  # TODO: Add this method into error checking before piece placement
  def piece_move_real?(from, to)
    if board.a_piece?(from)
      board.make_move(from, to)
    else
      error.piece
      set_move
    end
  end

  def move_from
    @from = gets.chomp.downcase
    return @from if @from && input_check?(@from)

    error.input_error
    move_from
  end

  def move_to
    @to = gets.chomp.downcase
    return @to if @to && input_check?(@to)

    error.input_error
    move_to
  end

  def input_check?(input)
    input.split('').length == 2 && input[0].match?(/[a-h]/) && input[1].match?(/[1-8]/)
  end
end

chess = Game.new
chess.play_game
