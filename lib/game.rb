# frozen_string_literal: true

require_relative './board'
require_relative './error'
require_relative './modules/vector'
require 'pry'

# game class is responsbile for game loop and game logic
class Game
  Player = Struct.new(:name, :color)
  include Vector
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to, :error, :diag_val, :current
  def initialize
    @player1 = Player.new('Henry', :white)
    @player2 = Player.new('Sarah', :black)
    @board = Board.new
    @error = Error.new
    @current_player = nil
    @answer = nil
    @from = nil
    @to = nil
    @diag_val = nil
    @current = current
    @current_player = player1
  end

  # TODO: create set_players and intro_text
  def start_game
    # set_players
    # intro_text
    play_game
  end

  def play_game
    loop do
      board.display_board
      # checkmate?
      check? ? in_check(current_player) : false
      puts "\n#{current_player.name}, make a move"
      set_move
      turn_switcher
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
  end

  def vet_piece_move?(from, to)
    piece = board.get_active_piece(from)
    validate_turn(from, piece)
    # valid_piece_move?(from, to, piece) ? board.make_move(from, to) : valid_move_false(from, to)
    board.make_move(from, to)
    puts_king_in_check?(from, to)
    validate_move_true(from, to)
  end

  # def pawn_checkmate?(check_moves)
  #   check_moves = check_moves.flatten
  #   board.game_board.each_with_index do |row, x|
  #     row.each_with_index do |_col, y|
  #       piece = board.game_board[x][y]
  #       from = x, y
  #       next unless piece != '   ' && piece.color == current_player.color && piece.class.name == 'Pawn'

  #       pawn_moves = piece.all_pawn_moves(from)

  #       if pawn_moves.include?(check_moves) && valid_piece_move?(from, check_moves, piece)
  #         puts 'a pawn can stop check'
  #       end
  #     end
  #   end
  # end

  # take the moves generated from check
  def checkmate?(check_moves)
    check_moves = check_moves.flatten
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        next unless piece != '   ' && piece.color != current_player.color && piece.class.name != 'Pawn'

        piece&.starting_moves(from, _to = nil)
        possible_moves = piece.moves
        if possible_moves.include?(check_moves) && valid_piece_move?(from, check_moves, piece)
          puts 'a piece that is NOT a pawn can stop check'
        end
      end
    end
  end

  # ensures that subsequent move does not put king in check
  def puts_king_in_check?(from, to)
    if check?
      error.bad_check_move(current_player)
      board.make_move(to, from)
      play_game
    else
      true
    end
  end

  def valid_piece_move?(from, to, piece)
    piece.starting_moves(from, to)
    case piece.class.name
    when 'Pawn'
      legal_move?(from, to, piece) && piece.capture_piece(from, to, board.game_board) ? true : false
      # binding.pry
    when 'King'
      legal_move?(from, to, piece) ? true : false
    when 'Knight'
      validate_knight?(to, piece) && piece.check_moves?(to) ? true : false
    else
      legal_move?(from, to, piece) ? true : false
    end
  end

  def legal_move?(from, to, piece)
    check_if_piece_in_way?(from, to, piece) && piece.check_moves?(to) && legal_capture?(current, to, piece) ? true : false
  end

  def check_if_piece_in_way?(from, to, piece)
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

  def check_king(king_pos, possible_moves)
    moves = []
    # p possible_moves
    possible_moves.each do |pos|
      moves << pos if pos == king_pos
    end
    moves
  end

  def king_position
    pos = ''
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        pos = [x, y] if piece != '   ' && piece.class.name == 'King' && piece.color == current_player.color
      end
    end
    pos
  end

  def pawn_check?
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        next unless piece != '   ' && piece.color != current_player.color && piece.class.name == 'Pawn'

        pawn_moves = piece.all_pawn_moves(from)
        player_king_pos = king_position
        possible_pawn_check_moves = check_king(player_king_pos, pawn_moves)
        until possible_pawn_check_moves.empty?

          to = possible_pawn_check_moves.first
          valid_piece_move?(from, to, piece)
          return true if valid_piece_move?(from, to, piece)

          possible_pawn_check_moves.shift
        end
      end
    end
    false
  end

  def double_check?
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        next unless piece != '   ' && piece.color != current_player.color && piece.class.name != 'Pawn'

        piece&.starting_moves(from, _to = nil)
        possible_moves = piece.moves
        player_king_pos = king_position
        possible_check_moves = check_king(player_king_pos, possible_moves)
        # checkmate?(possible_check_moves, piece)

        until possible_check_moves.empty?
          # pawn_checkmate?(possible_check_moves)
          checkmate?(possible_check_moves)
          to = possible_check_moves.first
          return true if valid_piece_move?(from, to, piece)

          possible_check_moves.shift
        end
      end
    end
    false
  end

  def in_check(current_player)
    error.check_error(current_player)
  end

  def check?
    double_check? || pawn_check? ? true : false
  end

  def still_in_check(from, to)
    return unless check?

    in_check(current_player)
    board.make_move(to, from)
    play_game
  end

  def validate_move_true(from, to)
    still_in_check(from, to)
  end

  def valid_move_false(_from, _to)
    error.input_error
    play_game
  end

  def validate_turn(from, piece)
    x, y = from
    return unless board.game_board[x][y].is_a?(String) || current_player.color != piece.color

    error.turn_error
    play_game
  end

  def turn_switcher
    @current_player = @current_player == player1 ? player2 : player1
  end

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
