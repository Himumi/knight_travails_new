class Travails

  # return list of hash  'child => parent'
  def shortest_path(source, target)
    recorder = {}
    queue = add_all_directions_of(source, recorder)

    loop do
      first = queue.shift
      child, parent = first[0], first[1]

      next if recorder[child]

      recorder[child] = parent

      return recorder if child == target

      queue += add_all_directions_of(child, recorder)
    end
  end

  # return path from source to target based 'shortest_path' method
  # [[source], [path], [target]]

  # trace from target until source
  def track(source, target, recorder)
    result = []
    current = target

    loop do
      result.unshift(current)

      return result if current == source

      current = recorder[current]
    end
  end

  # return next direction of source specifically
  def direction_of(root, way)
    a, b = root[0], root[1]

    paths = [
      [a-1, b-2], [a-2, b-1], [a-2, b+1], [a-1, b+2],
      [a+1, b+2], [a+2, b+1], [a+2, b-1], [a+1, b-2]
    ]

    return nil if paths[way].any? { |i| !i.between?(0, 7) }

    paths[way]
  end

  # return list of next directions that is not in recorder and not nil
  # reduce list before add it to queue
  def add_all_directions_of(source, recorder)
    result = []

    8.times do |way|
      direction = direction_of(source, way)

      result << [direction, source] if !direction.nil? && !recorder[direction]
    end

    result
  end

  def convert_to_indexes(key)
    letters = {
      'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3,
      'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7
    }

    numbers = {
      '1' => 7, '2' => 6, '3' => 5, '4' => 4,
      '5' => 3, '6' => 2, '7' => 1, '8' => 0
    }

    letter = letters[key[0]]
    number = numbers[key[1]]

    return nil if letter.nil? || number.nil?

    [number, letter]
  end

  def convert_to_key(index)
    return nil unless index.length == 2

    letters = {
      0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd',
      4 => 'e', 5 => 'f', 6 => 'g', 7 => 'h'
    }

    numbers = {
      0 => '8', 1 => '7', 2 => '6', 3 => '5',
      4 => '4', 5 => '3', 6 => '2', 7 => '1'
    }

    number = numbers[index[0]]
    letter = letters[index[1]]

    return nil if number.nil? || letter.nil?

    "#{letter}#{number}"
  end
end
