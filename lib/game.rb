# frozen_string_literal: true

require_relative './board'

# game class is responsbile for game loop
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer
  def initialize
    @player1 = Player.new('Henry', :white)
    @player2 = Player.new('Sarah', :black)
    @board = Board.new
    @current_player = nil
    @answer = nil
  end

  #TODO: create set_players and intro_text
  def start_game
    # set_players
    # intro_text
    play_game
  end

  def play_game
    loop do
      @board.display_board
      puts "\n#{current_player.name}, Please make a guess"
      get_move
    end
  end

  def get_move
    puts 'Please give the co-ordinates of the piece you are moving'
    from = gets.chomp
    puts 'And where are you moving it?'
    to = gets.chomp
  end
end
