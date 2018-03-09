require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class BattleshipGame
  def initialize(player, board)
  	@current_player, @next_player = player
    @current_board, @next_board = board
  end
  def play
    setup
    until over?
      render
      play_turn
    end
    render
    game_over
  end
  private
  def setup
    if @next_player
      @current_player.setup(@current_board)
      @next_player.setup(@next_board)
      switch_boards!
    else
      @current_player.setup(@current_board, false)
    end
  end
  def sign
    @current_board.sign
  end
  def render
    intro
    @current_board.display
  end
  def attack(pos)
    return unless @current_board.in_range?(pos)
    @current_board[pos] = sign[:wreck] if hit?(pos)
  end
  def hit?(pos)
  	@current_board[pos] == sign[:ship]
  end
  def play_turn
    puts "#{@current_player.name}'s turn"
    puts "remaining ships: #{@current_board.count}"
    attack(@current_player.get_play)
    return unless @next_player
    switch_players!
    switch_boards!
  end
  def switch_players!
    @current_player, @next_player = @next_player, @current_player
  end
  def switch_boards!
    @current_board, @next_board = @next_board, @current_board
  end
  def over?
    @current_board.won?
  end
  def game_over
    puts "game over, #{@current_player.name} win!"
  end
end

def intro
  system("clear") || system("cls")
  puts "let's play battleship!"
  puts
end

def init_player(role)
  print "choose computer (enter) or human (y) as #{role}: "
  gets.chomp == "" ? ComputerPlayer.new(role) : HumanPlayer.new(role)
end

def init_mode
  print "choose one player (enter) or two players (2): "
  gets.chomp == "" ? one_player_mode : two_player_mode
end

def one_player_mode
  player1, board1 = init_player("player"), Board.new
end

def two_player_mode
  player1, board1 = init_player("player 1"), Board.new
  player2, board2 = init_player("player 2"), Board.new
  [[player1, player2], [board1, board2]]
end

if __FILE__ == $PROGRAM_NAME
  intro
  player, board = init_mode
  BattleshipGame.new(player, board).play
end