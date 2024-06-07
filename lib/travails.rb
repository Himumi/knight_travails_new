class Travails

  def direction(root, way)
    a, b = root[0], root[1]

    paths = [
      [a-1, b-2], [a-2, b-1], [a-2, b+1], [a-1, b+2],
      [a+1, b+2], [a+2, b+1], [a+2, b-1], [a+1, b-2]
    ]

    return nil if paths[way].any? { |i| !i.between?(0, 7) }

    paths[way]
  end

  def add_all_directions(source, recorder)
    result = []

    8.times do |way|
      adjacent = direction(source, way)

      result << [adjacent, source] if !adjacent.nil? and !recorder[adjacent]
    end

    result
  end

  def shortest_path(source, target)
    recorder = {}
    queque = add_all_directions(source, recorder)

    loop do
      first = queque.shift
      child, parent = first[0], first[1]

      next if recorder[child]

      recorder[child] = parent

      return recorder if child.eql?(target)

      queque += add_all_directions(child, recorder)
    end
  end

  def track(source, target, recorder)
    result = []
    current = target

    loop do
      result.unshift(current)

      return result if current.eql?(source)

      current = recorder[current]
    end
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

    return nil if letter.nil? or number.nil?

    [number, letter]
  end
end
