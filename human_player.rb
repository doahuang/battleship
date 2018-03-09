class HumanPlayer
  attr_reader :name
  def initialize(name = nil)
    @name = name
  end
  def setup(board, custom = true)
    @board = board
    custom ? customize_board : board.populate_grid
  end
	def get_play
    print "where to attack: "
    get_pos
	end
  private
  def get_pos
    pos = gets.chomp.split(",").join(" ").split
    pos.map(&:to_i)
  end
  def customize_board
    @board.size.times do |num|
      render
      print "where is ship #{num + 1}: "
      place_ship(get_pos)
    end
  end
  def render
    system("clear") || system("cls")
    puts "let's play battleship!"
    puts
    @board.display(true)
    puts "#{name}'s board setup"
  end
  def place_ship(pos)
    @board[pos] = @board.sign[:ship] if @board.in_range?(pos)
    @board.place_random_ship unless @board.in_range?(pos)
  end
end