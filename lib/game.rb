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
        if board.cells[subarray[0]] == board.cells[subarray[1]] && board.cells[subarray[1]] == board.cells[subarray[2]] && board.taken?(subarray[0] + 1)
            return subarray 
        end 
    end
    false
  end 
  
  def draw? 
    board.full? && !won?
  end 
  
  def over? 
    won? || draw? 
  end 
  
  def winner 
    winning_row = won?
    if winning_row
      if board.cells[winning_row[0]] == 'X' 
        'X'
      else  
        'O'
      end 
    end 
  end 
  
  def turn
    puts "Put a number between 1-9:"
    input = current_player.move(board)
    if board.valid_move?(input)
        board.update(input, current_player)
      else 
        turn
      end 
  end 
  

def play 
    while !over? 
      turn 
    end 
    if won? 
      puts "Congratulations #{winner}!"
    elsif draw? 
      puts "Cat's Game!"
    end 
  end 

end 
