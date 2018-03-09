class ComputerPlayer
  attr_reader :name
  def initialize(name = nil)
    @name = name
  end
  def setup(board, custom = true)
    @board = board
    board.populate_grid
    @fire_lot = matrix
  end
  def get_play
    pos = @fire_lot.sample
    @fire_lot.delete(pos)
  end
  private
  def matrix
    lot = []
    @board.size.times do |x|
      @board.size.times do |y|
        lot << [x, y]
      end
    end
    lot
  end
end