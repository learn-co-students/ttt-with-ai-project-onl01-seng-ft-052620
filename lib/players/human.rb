module Players
    class Human < Player
        def move(cells)
            puts "Enter your desired position:"
            gets.strip
        end
    end
end