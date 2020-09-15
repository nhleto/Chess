# frozen_string_literal: true

require_relative './board'
require_relative './error'
require_relative './modules/vector'
require 'pry'

# game class is responsbile for game loop and game logic
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to, :error, :diag_val, :current
  def initialize
    @player1 = Player.new('Henry', 'white')
    @player2 = Player.new('Sarah', 'black')
    @board = Board.new
    @error = Error.new
    @current_player = nil
    @answer = nil
    @from = nil
    @to = nil
    @diag_val = nil
    @current = current
  end

  # TODO: create set_players and intro_text
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
      board.display_board
      attempts += 1
    end
  end

  def set_move
    puts "\nPlease give the co-ordinates of the piece you are moving"
    move_from
    start_move = board.input_to_coords(from)
    puts 'And where are you moving the piece to?'
    move_to
    end_move = board.input_to_coords(to)
    vet_piece_move?(start_move, end_move)
    board.move_it(from, to)
  end

  # Have this method return a boolean and eventually chain it together with piece_move_real?
  def vet_piece_move?(from, to)
    piece = board.get_active_piece(from)
    # piece.starting_moves(from, to)
    # p check_horizontal_same?(from, to, piece) # return true if left / right pieces are the same color
    # p check_vertical_same?(from, piece) # return true if up / down pieces are the same color
    # p check_diagonal_same?(from, to, piece) # return false if piece passes through another piece/true if [to] == '   '
    p valid_piece_move?(from, to, piece)
  end

  def valid_piece_move?(from, to, piece)
    # binding.pry
    case piece.class.name
    when 'Pawn'
      check_piece_in_way?(from, to, piece) && piece.starting_moves(from, to) && legal_capture?(current, to, piece) ? true : false
      # binding.pry
    when 'King'
      puts 'its a king'
      check_piece_in_way?(from, to, piece) && piece.starting_moves(from, to) && legal_capture?(current, to, piece) ? true : false
    when 'Knight'
      validate_knight?(to, piece) && piece.starting_moves(from, to) ? true : false
    else
      p piece.class.name
      check_piece_in_way?(from, to, piece) && piece.starting_moves(from, to) && legal_capture?(current, to, piece) ? true : false
    end
  end

  # Return true if the piece to the left / right is same color or '   '
  def check_piece_in_way?(from, to, piece)
    x, y = from
    direction_x, direction_y = Vector.create_direction_vector(from, to)
    from_equals_to?(from, to)

    @current = []
    @current << (x + direction_x)
    @current << (y + direction_y)

    until current == to

      return false if board.game_board[current[0]][current[1]] != '   '

      current[0] += direction_x
      current[1] += direction_y
    end
    legal_capture?(current, to, piece)

    true
  end

  def legal_capture?(current, to, piece)
    i, j = to
    if board.game_board[current[0]][current[1]] == board.game_board[i][j] && board.game_board[i][j] != '   '
      @diag_val = board.game_board[current[0]][current[1]]
      parse_diag_value(piece)
    else
      true
    end
  end

  def parse_diag_value(piece)
    if diag_val.color != piece.color
      reset_diag_val
      true
    elsif diag_val.color == piece.color
      reset_diag_val
      false
    end
  end

  def validate_knight?(to, piece)
    i, j = to
    if board.game_board[i][j] != '   '
      destination = board.game_board[i][j]
      if destination.color != piece.color
        true
      elsif destination.color == piece.color
        false
      end
    else
      true
    end
  end

  private

  def reset_diag_val
    @diag_val = nil
  end

  def from_equals_to?(from, to)
    return false if from == to
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
