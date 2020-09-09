# frozen_string_literal: true

require_relative './board'
require_relative './error'
require 'pry'

# game class is responsbile for game loop
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

  #TODO: create set_players and intro_text
  def start_game
    # set_players
    # intro_text
    play_game
  end

  def play_game
    attempts = 0
    while attempts < 3
      board.display_board
      puts 'Make a move'
      set_move
      attempts += 1
    end
  end

  def set_move
    puts 'Please give the co-ordinates of the piece you are moving'
    move_from
    puts 'And where are you moving it to?'
    move_to
    board.stage_move(@from, @to)
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

# chess = Game.new
# chess.play_game
