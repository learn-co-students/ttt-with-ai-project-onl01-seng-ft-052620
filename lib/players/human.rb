module Players
    class Human < Player
        
        
      
        def move(board)
            
            puts "Give me a move (1-9): "
            user_move = gets.chomp
        
        end
        
    end
end