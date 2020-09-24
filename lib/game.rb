# frozen_string_literal: true

require_relative './board'
require_relative './error'
require_relative './modules/vector'
require_relative './modules/checkmate'
require_relative './modules/helpermethods'
require 'pry'

# game class is responsbile for game loop and game logic
class Game
  Player = Struct.new(:name, :color)
  attr_reader :board, :player1, :player2, :current_player, :answer, :from, :to, :error, :diag_val, :current, :safe_moves
  include Checkmate
  include Vector
  include BoardCoords
  include HelperMethods
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
    @safe_moves = nil
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
      check_if_checkmate?
      check_if_pawn_checkmate?
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
    # p checking_piece(from)
    piece = board.get_active_piece(from)
    validate_turn(from, piece)
    valid_piece_move?(from, to, piece) ? board.make_move(from, to) : valid_move_false(from, to)
    # board.make_move(from, to)
    puts_king_in_check?(from, to)
    # p legal_king_moves(king_position, to)
    still_in_check(from, to)
    promote_pawn?(to, piece)
  end

  def valid_piece_move?(from, to, piece)
    piece.starting_moves(from, to)
    case piece.class.name
    when 'Pawn'
      piece.en_passant(from, board.game_board)
      legal_move?(from, to, piece) && piece.capture_piece(from, to, board.game_board) ? true : false
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

  # take the moves generated from check
  def checkmate?(from_1, piece_1)
    all_possible_moves = []
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        unless piece != '   ' && piece.color == current_player.color && piece.class.name != 'Pawn' && piece.class.name != 'King'
          next
        end

        p final_mate?(from_1, piece_1, all_possible_moves)

        piece&.starting_moves(from, _to = nil)
        possible_moves = piece.moves.uniq
        until possible_moves.empty?
          if valid_piece_move?(from, possible_moves.first, piece)
            all_possible_moves << possible_moves.first unless possible_moves.first == []
          end
          possible_moves.shift
        end
      end
    end
    # false
  end

  # uses checkmate helper methods to see if there are any valid moves out of check. if not, it is mate.
  def final_mate?(from1, piece1, all_possible_moves)
    !block_check?(piece1, from1, all_possible_moves) && !can_take_piece?(all_possible_moves, from1) && @safe_moves == 0
  end

  def checkmate_message
    opponent = current_player == @player1 ? @player2 : @player1
    puts "\n#{current_player.name} has been mated. #{opponent.name} is the winner!".green
  end

  # ensures that subsequent move does not put king in check
  def puts_king_in_check?(from, to)
    if check?
      legal_king_moves(from, to = nil)
      error.bad_check_move(current_player)
      board.make_move(to, from)
      play_game
    else
      true
    end
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
          # checkmate?(from, piece)
          return true if valid_piece_move?(from, to, piece)

          possible_pawn_check_moves.shift
        end
      end
    end
    false
  end

  def mate
    puts "CHECKMATE. #{opponent.name} is the winner and the game is over.".green
    exit
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
        until possible_check_moves.empty?
          to = possible_check_moves.first
          # checkmate?(from, piece)
          return true if valid_piece_move?(from, to, piece)

          possible_check_moves.shift
        end
      end
    end
    false
  end

  def check_if_checkmate?
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        next unless piece != '   ' && piece.color != current_player.color && piece.class.name != 'Pawn'

        piece&.starting_moves(from, _to = nil)
        possible_moves = piece.moves
        player_king_pos = king_position
        possible_check_moves = check_king(player_king_pos, possible_moves)
        until possible_check_moves.empty?
          checkmate?(from, piece)
          possible_check_moves.shift
        end
      end
    end
  end

  def check_if_pawn_checkmate?
    board.game_board.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        piece = board.game_board[x][y]
        from = x, y
        next unless piece != '   ' && piece.color != current_player.color && piece.class.name == 'Pawn'

        pawn_moves = piece.all_pawn_moves(from)
        player_king_pos = king_position
        possible_pawn_check_moves = check_king(player_king_pos, pawn_moves)
        until possible_pawn_check_moves.empty?
          checkmate?(from, piece)
          possible_pawn_check_moves.shift
        end
      end
    end
  end

  def in_check(current_player)
    error.check_error(current_player)
    legal_king_moves(king_position, to)
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

  def opponent
    opponent = current_player == @player1 ? @player2 : @player1
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
