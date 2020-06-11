require 'pry'

module Players

    class Computer < Player
        
        def move(board)
            moves = [1,2,3,4,6,7,8,9]
            
            binding.pry
            if board.valid_move?(5)
                move ='5'
            end
        end


    end



end