# frozen_string_literal: true

# player input to board coordinate
module BoardCoords
  def self.create_coord(input)
    arr = []
    input = input.split('')
    x_coord = input[1]
    y_coord = input[0]

    case x_coord.to_i
    when 1
      arr << 7
    when 2
      arr << 6
    when 3
      arr << 5
    when 4
      arr << 4
    when 5
      arr << 3
    when 6
      arr << 2
    when 7
      arr << 1
    when 8
      arr << 0
    end

    case y_coord
    when 'a'
      arr << 0
    when 'b'
      arr << 1
    when 'c'
      arr << 2
    when 'd'
      arr << 3
    when 'e'
      arr << 4
    when 'f'
      arr << 5
    when 'g'
      arr << 6
    when 'h'
      arr << 7
    end
    arr
  end

  def self.revert(input)
    arr = []
    x_coord = input[1]
    y_coord = input[0]

    case x_coord.to_i
    when 7
      arr << 1
    when 6
      arr << 2
    when 5
      arr << 3
    when 4
      arr << 4
    when 3
      arr << 5
    when 2
      arr << 6
    when 1
      arr << 7
    when 0
      arr << 8
    end

    case y_coord
    when 0
      arr << 'a'
    when 1
      arr << 'b'
    when 2
      arr << 'c'
    when 3
      arr << 'd'
    when 4
      arr << 'e'
    when 5
      arr << 'f'
    when 6
      arr << 'g'
    when 7
      arr << 'h'
    end
    arr
  end
end
