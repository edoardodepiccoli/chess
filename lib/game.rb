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
    system('clear')
    @board.print_board

    current_player = @players.first
    player_move = current_player.move # [[start_row, start_col], [end_row, end_col]]

    until @board.move_valid?(current_player, player_move)
      player_move = current_player.move # [[start_row, start_col], [end_row, end_col]]
    end

    @board.make_move(player_move)

    switch_turn

    if @board.checkmate?(@players.first)
      system('clear')
      @board.print_board

      puts "checkmate for #{@players.first.color}"
      return
    end

    play_round
  end

  def switch_turn
    @players = @players.rotate
  end
end
