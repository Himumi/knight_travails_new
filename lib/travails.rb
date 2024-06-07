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

  def convert_to_key(index)
    return nil unless index.length.eql?(2)

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

    return nil if number.nil? or letter.nil?

    "#{letter}#{number}"
  end

  def print_path(tracker)
    path = ""
    last = tracker.length - 1

    tracker.each_with_index do |item, i|
      converted = convert_to_key(item)

      path += (i.eql?(last) ? " #{converted}" : " #{converted} " + ">" * (i + 1))
    end

    puts path
  end

  def print_board(tracker)
    letters = "       A   B   C   D   E   F   G   H  "
    dashed = "     ---------------------------------"

    puts letters, dashed

    8.times do |row|
      line = "  #{8 - row}  |" # Add letter for each row

      8.times do |column|
        line += (tracker.include?([row, column]) ? " \u2658 |" : "   |" )

        line += "  #{8 - row}" if column.eql?(7) # Add letter after last column
      end

      puts line, dashed
    end

    puts letters
  end
end
