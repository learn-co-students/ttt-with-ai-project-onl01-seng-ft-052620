module Players

class Human < Player
    def move(boardinstance)
        puts "Please enter a number: "
        input = gets.chomp
    end 
end 

end 