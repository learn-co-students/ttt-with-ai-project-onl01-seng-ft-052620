class Game
    
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    attr_accessor :board, :player_1, :player_2

    def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        if @board.turn_count%2 == 0
            @player_1
        else
            @player_2
        end
    end

    def won?
        
        WIN_COMBINATIONS.each do |win_combo|
            if win_combo.all?{|index| @board.cells[index] == 'X'} 
                return win_combo
            
            elsif win_combo.all?{|index| @board.cells[index] == 'O'}
                return win_combo
            end
        end
        false
    end

    def draw?
        @board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        @board.cells[won?[0]] if won?
    end

    def turn 
        user_move = current_player.move(@board)

        if @board.valid_move?(user_move)
            @board.update(user_move, current_player)
            system("clear")
        else
            turn
        end
    end

    def play
        
        while !over?
            turn
            @board.display
        end
        
        
        if won?
            puts "Congratulations #{winner}!"

        else
            puts "Cat's Game!" 
        end
           
    end

    def start
        @board.display
        play
    end

end