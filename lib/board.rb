class Board 

    attr_accessor :cells
    
    def initialize
        @cells = []
        board_creator(9)
    end

    def reset!
        @cells.clear
        board_creator(9)
    end

    def board_creator(size)
        size.times { @cells << " "}
    end

    def display 
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
        
    end

    def position(user_pos)
        board_pos = user_pos.to_i - 1
        @cells[board_pos]
    end

    def full?

        @cells.all?{ |cell| cell != ' '}

    end

    def turn_count
        @cells.count{|cell| cell != ' '}
    end

    def taken?(user_pos)

        (position(user_pos) == 'X') || (position(user_pos) == 'O')

    end

    def valid_move?(user_move)
        user_move.to_i > 0 && user_move.to_i <= 9 && !(taken?(user_move))
    
    end

    def update(user_move, player)
        @cells[user_move.to_i-1] = player.token if valid_move?(user_move)
    end
end