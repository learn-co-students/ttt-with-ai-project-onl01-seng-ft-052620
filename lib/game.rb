require "pry"
class Game

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
      ]
      
    attr_accessor :board, :player_1, :player_2

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        self.board = board
        self.player_1 = player_1
        self.player_2 = player_2
    end

    def current_player
        self.board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.find do |win_combination|
            win_index_1 = win_combination[0]
            win_index_2 = win_combination[1]
            win_index_3 = win_combination[2]
        
            position_1 = self.board.cells[win_index_1]
            position_2 = self.board.cells[win_index_2]
            position_3 = self.board.cells[win_index_3]
        
            if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
                return win_combination
            else
                false 
            end
        end
    end


    def draw?
        self.board.full? && !self.won?
    end

    def over?
        self.won? || self.board.full? || self.draw?
    end

    def winner
        if won?
            win_combination = self.won?
            self.board.cells[win_combination.first]
        else
            nil
        end
    end

    
    def turn 
        player = current_player 
        puts "Hello #{player.token} you are up!" 
        @board.display 
        input = player.move(@board)
        if @board.valid_move?(input) 
            @board.update(input, player) 
        else 
            puts"Invalid move, please try another" 
            turn 
        end 
    end 

    def play
        while !over? && !won?
            turn
        end 
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end
