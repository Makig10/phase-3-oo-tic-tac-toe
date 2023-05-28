class TicTacToe
    def initialize
      @board = Array.new(9, " ")
    end
  
    WIN_COMBINATIONS = [
      [0,1,2], # Top row
      [3,4,5], # Middle row
      [6,7,8], # Bottom row
      [0,3,6], # Left column
      [1,4,7], # Middle column
      [2,5,8], # Right column
      [0,4,8], # Diagonal 1
      [2,4,6]  # Diagonal 2
    ]
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  
    def input_to_index(input)
      input.to_i - 1
    end
  
    def move(index, token = "X")
      @board[index] = token
    end
  
    def position_taken?(index)
      @board[index] != " "
    end
  
    def valid_move?(index)
      index.between?(0, 8) && !position_taken?(index)
    end
  
    def turn_count
      @board.count { |token| token == "X" || token == "O" }
    end
  
    def current_player
      turn_count.even? ? "X" : "O"
    end
  
    def turn
      puts "Please enter a number between 1-9:"
      input = gets.chomp
      index = input_to_index(input)
      
      if valid_move?(index)
        token = current_player
        move(index, token)
        display_board
      else
        puts "Invalid move. Please try again."
        turn
      end
    end
  
    def won?
      WIN_COMBINATIONS.each do |combo|
        if @board[combo[0]] == @board[combo[1]] &&
           @board[combo[1]] == @board[combo[2]] &&
           position_taken?(combo[0])
          return combo
        end
      end
      false
    end
  
    def full?
      @board.all? { |token| token == "X" || token == "O" }
    end
  
    def draw?
      full? && !won?
    end
  
    def over?
      won? || draw?
    end
  
    def winner
      if combo = won?
        @board[combo[0]]
      end
    end
  
    def play
      until over?
        turn
      end
  
      if won?
        puts "Congratulations! Player #{winner} wins!"
      else
        puts "It's a draw!"
      end
    end
  end