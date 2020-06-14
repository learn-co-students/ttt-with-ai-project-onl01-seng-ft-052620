require 'pry'

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
    @cells[input.to_i - 1]
   end 

   def full? 
    @cells.none?{|cell| cell == " "}
   end 

   def turn_count 
    @cells.count{|cell| cell != " "}
   end 

   #def taken?(number) 
    #@cells[number.to_i - 1] == "O" || @cells[number.to_i - 1] == "X"
   #end 

   def taken?(number)
    position(number) == 'X' || position(number) == 'O'
   end 

   def valid_move?(number)
    number.to_i.between?(1, 9) && !taken?(number)
   end 

   def update(number, player)
    if turn_count.even?
    @cells[number.to_i - 1] = "X" 
    else 
    @cells[number.to_i - 1] = "O"
    end 
   end 

end 