module Players
    class Computer < Player
        def move(board)
            valid_moves = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
            output = valid_moves[rand(valid_moves.size)]
            if board.valid_move?(output)
            output
            end
        end
    end
end