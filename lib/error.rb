# frozen_string_literal: true

require 'colorize'

# outputting error messages
class Error
  def input_error
    puts 'Please enter valid input...'.red
  end

  def pawn_movement
    puts 'This is not a valid move for a pawn. Please try again...'.red
  end

  def piece
    puts "\nYou did not select a valid piece".red
  end

  def turn_error
    puts "\nThat is not your piece. Guess again...".red
  end

  def check_error(current_player)
    puts "\n#{current_player.name}, you are in check. You must move your King out of check unless it is in checkmate...".yellow
  end

  def not_in_check(current_player)
    puts "\n#{current_player.name}, you are not in check anymore.".green
  end
end
