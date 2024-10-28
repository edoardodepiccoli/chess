require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @turn = 0
  end

  def play
    play_round
  end

  private

  def play_round
    system 'clear'
    @board.print_board

    current_player = @players[@turn]
    if @board.checkmate?(current_player)
      system 'clear'
      @board.print_board
      puts "checkmate for #{current_player.color}:"
      switch_turn
      puts "#{current_player.color} wins!"
      return
    end

    print "player #{current_player.color}, make a move: "
    player_move = current_player.get_move

    until @board.move_valid?(current_player, player_move)
      player_move = current_player.get_move
    end

    @board.make_move(player_move)

    switch_turn
    play_round
  end

  def switch_turn
    @turn = @turn == 0 ? 1 : 0
  end
end
