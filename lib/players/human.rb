module Players
    class Human < Player
        def move(board)
         puts "Input number between 1-9"
         input = gets.strip
         input
        end
    end
end