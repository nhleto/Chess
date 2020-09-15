# frozen_string_literal: true

require_relative './board'
require_relative './error'
require 'pry'

# game class is responsbile for game loop and game logic
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to, :error, :diag_val
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
    # board.get_active_piece(from)
    start_move = board.input_to_coords(from)
    puts 'And where are you moving the piece to?'
    move_to
    end_move = board.input_to_coords(to)
    vet_piece_move?(start_move, end_move)
    board.move_it(from, to)
    # piece_move_real?(start_move, end_move)
  end

  # Have this method return a boolean and eventually chain it together with piece_move_real?
  def vet_piece_move?(from, to)
    piece = board.get_active_piece(from)
    # piece.starting_moves(from, to)
    # p check_horizontal_same?(from, piece) # return true if left / right pieces are the same color
    # p check_vertical_same?(from, piece) # return true if up / down pieces are the same color
    p check_diagonal_same?(from, to, piece) # return true if piece passes through another piece
    # p valid_piece_move?(from, to, piece)
  end

  def valid_piece_move?(from, to, piece)
    # binding.pry
    case piece.class.name
    when 'Pawn'
      return true if check_horizontal_same?(from, piece) && piece.starting_moves(from, to)
    when 'King'
      puts 'its a king'
    when 'Queen'
      puts 'its a queen'
    when 'Bishop'
      puts 'its a bishop'
      # return true if check_diagonal_same?(from, to, piece) && piece.starting_moves(from, to)

      # binding.pry
      # return false

    end
  end

  # Return true if the piece to the left / right is same color or '   '
  def check_horizontal_same?(from, piece)
    adjacent_left_right_same?(from, piece)
  end

  def check_diagonal_same?(from, to, piece)
    x, y = from
    i, j = to
    direction_x, direction_y = create_direction_vector(from, to)
    from_equals_to?(from, to)

    current = []
    current << (x + direction_x)
    current << (y + direction_y)
    current << i
    current << j

    until current == to
      if board.game_board[current[0]][current[1]] != '   '
        @diag_val = board.game_board[current[0]][current[1]] # use value to parse if legal capture or not
        # parse_diag_value(piece)
        return false
      end

      current[0] += direction_x
      current[1] += direction_y
    end
    true
  end

  # def new_horizontal_check?(from, to, piece)
  #   x, y = from
  #   i, j = to
  #   direction_x, direction_y = create_direction_vector(from, to)
  #   from_equals_to?(from, to)

  #   current = []
  #   current << (x + direction_x)
  #   current << (y + direction_y)
  #   current << i
  #   current << j

  #   until current == to
  #     if board.game_board[current[0]][current[1]] != '   '
  #       @diag_val = board.game_board[current[0]][current[1]] # use value to parse if legal capture or not
  #       parse_diag_value(piece)
  #       return false
  #     end

  #     current[0] += direction_x
  #     current[1] += direction_y
  #   end
  #   true
  # end

  def parse_diag_value(piece)
    if diag_val.color != piece.color
      puts 'this is a legal capture'
      reset_diag_val
    end
  end

  private

  def reset_diag_val
    @diag_val = nil
  end

  def from_equals_to?(from, to)
    return false if from == to
  end

  def create_direction_vector(from, to)
    x, y = from
    i, j = to
    direction = []
    direction << sign((i - x))
    direction << sign((j - y))
  end

  def sign(num)
    num <=> 0
  end

  def check_vertical_same?(from, piece)
    x, y = from
    adjacent_piece_up = board.game_board[x - 1][y]
    adjacent_piece_down = board.game_board[x] == board.game_board[7] ? '   ' : board.game_board[x + 1][y]
    # binding.pry
    if adjacent_piece_up == '   ' && adjacent_piece_down == '   ' || adjacent_piece_up == '   ' && adjacent_piece_down.color == piece.color || adjacent_piece_down == '   ' && adjacent_piece_up.color == piece.color
      true
    elsif adjacent_piece_up == '   ' && adjacent_piece_down.color != piece.color
      false
    elsif adjacent_piece_up.color != piece.color && adjacent_piece_down == '   '
      false
    elsif adjacent_piece_up.color == piece.color && adjacent_piece_down.color == piece.color
      true
    elsif adjacent_piece_up.color != piece.color && adjacent_piece_down.color != piece.color
      false
    elsif board.game_board[x] == board.game_board[0] && adjacent_piece_up.color != piece.color && adjacent_piece_down.color == piece.color
      true
    end
  end

  def adjacent_left_right_same?(from, piece)
    # p from
    x, y = from
    adjacent_piece_left = board.game_board[x][y - 1]
    adjacent_piece_right = board.game_board[y] == board.game_board[7] ? '   ' : board.game_board[x][y + 1]
    # binding.pry
    if adjacent_piece_left == '   ' && adjacent_piece_right == '   ' || adjacent_piece_right == '   ' && adjacent_piece_left.color == piece.color || adjacent_piece_left == '   ' && adjacent_piece_right.color == piece.color
      true
    elsif adjacent_piece_left == '   ' && adjacent_piece_right.color != piece.color
      false
    elsif adjacent_piece_left.color != piece.color && adjacent_piece_right == '   '
      false
    elsif adjacent_piece_left.color != piece.color && adjacent_piece_right.color == piece.color
      false
    elsif adjacent_piece_left.color == piece.color && adjacent_piece_right.color != piece.color
      false
    elsif adjacent_piece_left.color == piece.color && adjacent_piece_right.color == piece.color
      true
    elsif adjacent_piece_left.color != piece.color && adjacent_piece_right.color != piece.color
      false
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
