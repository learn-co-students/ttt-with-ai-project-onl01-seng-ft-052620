require 'pry'

class CLI
    def call
        system("clear")
        greeting
        new_game = create_game(players)
        system("clear")
        new_game.start
        restart?
        system("clear")
    end
    
    def greeting
        puts "Welcome to the game of Tic Tac Toe."
    end

    # asks how many players will be playing returns the number of players
    def players
        
        puts "How many players will be playing today?"

        players = gets.chomp.to_i 
        
        valid_inputs = [0,1,2,100]
        
        
        until valid_inputs.include?(players)
            puts "Please enter a valid Input: "
            players = gets.chomp.to_i
        end

        players
        
    end

    # takes number of players - starts the game
    def create_game(num_players)
        # - Ask the user for who should go first and be "X". [√]
        # - Use the input to correctly initialize a Game with [√]
        # the appropriate player types and token values. 
        
        human_X = Players::Human.new("X")
        human_O = Players::Human.new("O")
        computer_X = Players::Computer.new("X")
        computer_O = Players::Computer.new("O")

        case num_players
        when 0
            Game.new(computer_X, computer_O)
        when 1
            puts "Who will go first? (ME or CPU)"
            first_player = gets.chomp
            
            case first_player.downcase
            
            when "me"
                Game.new(human_X, computer_O)
            
            when "cpu"
                Game.new(computer_X, human_O)
            end
        when 2
            Game.new
        when 100
            99.times{ Game.new(computer_X, computer_O).start}
            Game.new(computer_X, computer_O)
        end
    end
    
    def restart?
        puts "Would you like to restart? (Y/n)"
        ans = gets.chop.downcase

        if ans == 'y'
            system("clear")
            call
             
        else
            puts "Thanks for playing!"
            sleep (1)
        end
    end
end