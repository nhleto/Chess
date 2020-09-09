# frozen_string_literal: true

# outputting error messages
class Error
  def input_error
    puts 'Please enter valid input...'
  end

  def pawn_movement
    puts 'This is not a valid move for a pawn. Pleae try again...'
  end
end
