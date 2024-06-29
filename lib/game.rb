require_relative './travails.rb'

class Game < Travails

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

  def get_input
    message = "\nYou got wrong!! please input again"
    loop do
      input  = gets.chomp.split(" ")

      return input if exit?(input)

      next puts message if input.length != 2 or input[0] == input[1]

      return input if valid_input?(input[0]) && valid_input?(input[1])

      puts message # display when user gets wrong input
    end
  end

  def valid_input?(input)
    return false unless input.size == 2

    a, b = input[0], input[1]

    a.between?("a", "h") && b.between?("1", "8")
  end

  def exit?(input)
    input.first == "exit"
  end

  # print 'a0 > a1 >> a2 >>> a3'
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
end
