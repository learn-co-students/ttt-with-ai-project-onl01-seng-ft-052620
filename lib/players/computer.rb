module Players
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

    class Computer < Player
        attr_accessor :board
        def move(board)
            @board = board
            # @board.cells[0] = "X"
            # @board.cells[4] = "O"
            # current_token = self.token
            # possible_boards = see_next_boards(board, current_token)
            # new_board = possible_boards[0]
            # binding.pry
            possible = check_valid_moves()
            rand = (1..9).to_a.sample
            win = can_win?
            sleep(1)
            # if @board.cells.all?{|cell| cell == " "}
            #     rand
            if win
                win.first.to_s
            elsif block
                block.first.to_s
            elsif fork
                fork.to_s
            elsif center
                center.to_s
            elsif opponent_corner
                opponent_corner.to_s
            elsif !!empty_corner
                empty_corner.to_s
            elsif empty_side
                empty_side.to_s
            else
                rand.to_s
            end
        end

        #Check what moves I can make -> array of possible moves
        def check_valid_moves(board = @board)
            available_moves = board.cells.collect.each_with_index{|cell, index| index if cell == ' '}
            available_moves.reject{|cell| cell.nil?}
        end

        #find all the indexs of where my token is
        # def find_my_moves(board = @board)
        #     board.cells.collect.each_with_index{|cell,index| index if cell == self.token}.reject{|cell| cell.nil?}
        # end

        #looks at all possible future boards -> an array of an array of cells
        def future_boards(possible_moves, token = self.token, new_board = @board)            
            
            array_boards = []
        
            #creates an of array filled with current boards equal to the amount of moves
            possible_moves.each do |num|
                array_boards << Board.new
            end
            
            #enumerates through the board and adds different moves
            array_boards.each_with_index do |board, index| 
                board.cells = new_board.cells.clone
                board.cells[possible_moves[index]] = token
            end
            array_boards
        end
            
        #checks if there is a winning combo
        #Check if i can win takes an array of indexes -> returns an index of the winning move or false
        def can_win?(board = @board, token = self.token)
            
            #gathers all the possible boards
            possible_boards = future_boards(check_valid_moves(board), token, board)
            winning_moves = []
            #checks if there is a possible winning scenario
            WIN_COMBINATIONS.each do |win_combo|
                possible_boards.each do |new_board|
                    if win_combo.all?{|index| new_board.cells[index] == token} 
                        board.cells.each_with_index do |cell, index|
                            if new_board.cells[index] != cell
                                winning_moves << index+1
                            end
                        end
                    end
                end
            end
            if winning_moves.empty?
                false
            else
                winning_moves
            end
            #returns an index of the winning move or false
        end

        #Check if I need to block
            #If I make my next non win move
            #Will the next player have a win
            # If so then block.
        def new_state(board = @board, token = self.token)
            if token == "X"
                token = "O"
            else
                token = "X"
            end
            can_win?(board, token)
        end

        def block(board = @board, token = self.token)

            possible_boards = future_boards(check_valid_moves(board), token, board)
            possible_boards.each do |new_board|
                new_state = new_state(new_board, token)
                if new_state
                    return new_state
                end
            end
            return false
        end
        
        def next_token(token)
            if token == "X"
                token = "O"
            else
                token = "X"
            end
        end

        def see_next_boards(board, token)
            possible_boards = future_boards(check_valid_moves(board), token, board)
        end

        def fork
            current_token = self.token
            possible_boards = see_next_boards(board, current_token)
            possible_boards.each_with_index do |new_board, index|
                block_it = block(new_board, next_token(self.token))
                if block_it != false
                    new_board.cells[block_it.first-1] = next_token(self.token)
                    if can_win?(new_board, self.token)
                        @board.cells.each_with_index{|cell, index| return index+1 if new_board.cells[index] != cell}
                    end
                end
            end
            false
        end

        def center
            if @board.cells[4] == " "
                return 5
            else
                false
            end
        end

        def corner(index, token)
            if @board.cells[index] == token
                true
            else
                false
            end
        end

        def opponent_corner
            opposite_corners = [[0,8],[2,6]]
            opposite_corners.each do |opp|
                if corner(opp[1], " ") && corner(opp[0], next_token(self.token))
                    return opp[1]+1
                elsif corner(opp[0], " ") && corner(opp[1], next_token(self.token))
                    return opp[0]+1
                end
            end
            false
        end

        def empty_corner
            all_corners = [0,2,6,8]
            all_corners.each do |corn|
                if corner(corn, " ")
                    return corn+1
                end
            end
            false
        end

        def empty_side
            all_sides = [1,3,5,7]
            all_sides.each do |side|
                if corner(side, " ")
                    return side+1   
                end
            end
            false
        end
          
        # FORK - Create an opportunity where the player has two ways to win (two non-blocked lines of 2)
        # Blocking an opponent's fork
        # Center
        # Opposite corner: If the opponent is in the corner, the player plays the opposite corner.
        # Empty corner: The player plays in a corner square.
        # Empty side: The player plays in a middle square on any of the 4 sides.
    end
end