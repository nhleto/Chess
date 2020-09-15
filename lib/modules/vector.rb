# frozen_string_literal: true

# creates vector between from and to on board
module Vector
  def self.create_direction_vector(from, to)
    x, y = from
    i, j = to
    direction = []
    direction << sign((i - x))
    direction << sign((j - y))
  end

  def self.sign(num)
    num <=> 0
  end
end
