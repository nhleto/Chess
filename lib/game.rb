# frozen_string_literal: true

require_relative './board'
require 'pry'

# game class is responsbile for game loop
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to
  def initialize
    @player1 = Player.new('Henry', 'white')
    @player2 = Player.new('Sarah', 'black')
    @board = Board.new
    @current_player = nil
    @answer = nil
    @from = nil
    @to = nil
  end

  #TODO: create set_players and intro_text
  def start_game
    # set_players
    # intro_text
    play_game
  end

  def play_game
    attempts = 0
    while attempts < 1
      @board.display_board
      puts 'Make a move'
      get_move
      # @board.make_move(@from, @to)
      attempts += 1
    end
  end

  def get_move
    puts 'Please give the co-ordinates of the piece you are moving'
    @from = gets.chomp
    # binding.pry
    puts 'And where are you moving it?'
    @to = gets.chomp
    translate_move(@from, @to)
  end

  # TODO: Add in TO and FROM
  def translate_move
    from = '2a'
    board.display_board
    board.move_piece(from)
  end
end

chess = Game.new
chess.translate_move
