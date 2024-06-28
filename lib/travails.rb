class Travails
  def play
    puts introduction
    loop do
      input = get_input

      return exit_feedback if exit?(input)

      knight_moves(input[0], input[1])

      next_game_feedback
    end
  end

  private

  def introduction
    puts <<-HEREDOC

      This is knight Travails game that will provide you
    the shortest path from source to destination.

        From a1 to h8

            A   B   C   D   E   F   G   H
          ---------------------------------
        8  |   |   |   | ♞ |   |   |   | ♞ |  8
          ---------------------------------
        7  |   | ♞ |   |   |   | ♞ |   |   |  7
          ---------------------------------
        6  |   |   |   |   |   |   |   |   |  6
          ---------------------------------
        5  | ♞ |   |   |   |   |   |   |   |  5
          ---------------------------------
        4  |   |   |   |   |   |   |   |   |  4
          ---------------------------------
        3  |   | ♞ |   |   |   |   |   |   |  3
          ---------------------------------
        2  |   |   |   |   |   |   |   |   |  2
          ---------------------------------
        1  | ♞ |   |   |   |   |   |   |   |  1
          ---------------------------------
            A   B   C   D   E   F   G   H

      a1 > b3 >> a5 >>> b7 >>>> d8 >>>>> f7 >>>>>> h8

      You just have to put source and destination
    onto command line like

      a1 space h8 => a1 h8

    and to finish the game, just write 'exit'
    on command line.

    Please input source and destination.
    HEREDOC
  end

  def exit_feedback
    puts "\nOk Bye!!!"
  end

  def next_game_feedback
    puts "\nInput to play again or 'exit' to game over"
  end

  def get_input
    message = "\nYou got wrong!! please input again"
    loop do
      input  = gets.chomp.split(" ")

      return input if exit?(input)

      next puts message if input.length != 2 or input[0] == input[1]

      return input if valid_input?(input[0]) && valid_input?(input[1])
    end
  end

  def valid_input?(input)
    return false unless input.size == 2

    a, b = input[0], input[1]

    a.between?("a", "h") && b.between?("0", "8")
  end

  def exit?(input)
    input.first == "exit"
  end

  def knight_moves(source, target)
    source = convert_to_indexes(source)
    target = convert_to_indexes(target)

    recorder = shortest_path(source, target)
    tracker = track(source, target, recorder)

    puts ""
    print_board(tracker)
    puts ""
    print_path(tracker)
  end

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
      adjacent = direction_of(source, way)

      result << [adjacent, source] if !adjacent.nil? && !recorder[adjacent]
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

  # print like this 'a0 > a1 >> a2 >>> a3'
  def print_path(tracker)
    path = ""
    last = tracker.length - 1

    tracker.each_with_index do |item, i|
      converted = convert_to_key(item)

      path += (i == last ? " #{converted}" : " #{converted} " + ">" * (i + 1))
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
        line += (tracker.include?([row, column]) ? " \u265E |" : "   |" )

        line += "  #{8 - row}" if column == 7 # Add letter after last column
      end

      puts line, dashed
    end

    puts letters
  end
end
