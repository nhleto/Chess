# frozen_string_literal: true

# outputting error messages
class Error
  def input_error
    puts 'Please enter valid input...'
  end

  def pawn_movement
    puts 'This is not a valid move for a pawn. Please try again...'
  end

  def piece
    puts "\nYou did not select a valid piece"
  end
end
