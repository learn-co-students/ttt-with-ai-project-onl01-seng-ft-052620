class Game 

    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5], 
  [6,7,8], 
  [0,4,8], 
  [6,4,2],
  [0,3,6], 
  [1,4,7], 
  [2,5,8]
  ]



  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new())
    @board = board 
    @player_1 = player_1 
    @player_2 = player_2
  end 

  def current_player 
    board.turn_count.odd? ? player_2 : player_1
  end 

  def won? 
    WIN_COMBINATIONS.each do |subarray|
        if @cells[subarray[0]] == @cells[subarray[1]] && @cells[subarray[1]] == @cells[subarray[2]]
            return subarray 
        end 
    end
    false
  end 

 

end 
