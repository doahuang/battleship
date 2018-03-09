class Board
  attr_reader :grid
  def initialize(size = 5)
    @grid = Array.new(size){ Array.new(size) }
  end
  def sign
    { :ship => :s, :wreck => :* }
  end
  def [](pos)
    x, y = pos
    grid[x][y]
  end
  def []=(pos, mark)
    x, y = pos
    grid[x][y] = mark
  end
  def size
    grid.size
  end
  def count
    grid.reduce(0) do |sum, row|
      num = row.count(sign[:ship])
      num > 0 ? sum + num : sum
    end
  end
  def won?
    count == 0
  end
  def display(show_ship = false)
    puts "   " + (0...size).to_a.join(" ")
    grid.each_with_index do |row, i|
      if show_ship
        draw = row.map{ |pos| pos ? pos : " " }
      else
        draw = row.map{ |pos| pos == sign[:wreck] ? pos : " " }
      end
      puts " #{i} " + draw.join(" ")
    end
    puts
  end
  def populate_grid
    size.times{ place_random_ship }
  end
  def in_range?(pos)
    x, y = pos
    (0...size) === x && (0...size) === y
  end
  def place_random_ship
    pos = empty_lots.sample
    self[pos] = sign[:ship]
  end
  private
  def empty_lots
    lot = []
    grid.each_with_index do |row, x|
      row.each_with_index do |pos, y|
        lot << [x, y] unless pos
      end
    end
    lot
  end
end