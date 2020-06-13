class Board 
    attr_accessor :cells
    def initialize
       @cells = Array.new(9, " ")
    end
    def reset!
        @cells = Array.new(9, " ")
    end
    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end
    def position(input)
        position = input.to_i
        position -= 1
        @cells[position]
    end
    def full?
        if @cells.each.include?(" ")
            false
        else
            true 
        end
    end
    def turn_count
        @cells.count {|token| token == "X" || token == "O"}
    end
    def taken?(token)
        self.position(token) == ("X") || self.position(token) == ("O")
    end
    def valid_move?(num)
        num.to_i.between?(1,9)  && !taken?(num)
    end
    def update(input, player)
        if valid_move?(input)
            @cells[input.to_i - 1] = player.token
        end
    end
end
















