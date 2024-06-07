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
end
