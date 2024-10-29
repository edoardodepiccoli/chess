require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
  end

  def play
    play_round
  end

  private

  def play_round
    @board.print_board

    current_player = @players.first
    player_move = current_player.move # [[start_row, start_col], [end_row, end_col]]

    until @board.move_valid?(current_player, move)
      print 'invalid move, retry: '
      player_move = current_player.move # [[start_row, start_col], [end_row, end_col]]
    end

    @board.make_move(player_move)

    switch_turn
    play_round
  end

  def switch_turn
    @player = @players.rotate
  end
end