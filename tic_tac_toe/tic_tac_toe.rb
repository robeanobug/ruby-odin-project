# This is what the tic-tac-toe simulator will look like
# It has 9 positions
#
# 1 | 2 | 3
# --+---+--
# 4 | 5 | 6
# --+---+--
# 7 | 8 | 9
#
# The program will need:
# - Board class
# - board method to update it
# - Player class
# - 2 Human Players
# - method to select a position and update the position
# - errors for if a position has already been selected
#
# Steps:
# 1. Initialize the board
# 2. Puts the board
# 3. Ask current_player to enter a position
# 4. Check to see if the position is free
# 5. Update the board with an current_player's marker
# OR Puts "This position is taken...try again", revert to step 3
# 6. Puts the updated board
# 7. Check to see if current_player.marker is 3 in a row, puts "Woo! current_player won!" break loop
# 8 Check for any free spots ? continue : puts "It's a draw." break loop
# 9. Switch players
# 10. Loop back to step 3

LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

class Game
  def initialize
    @player1 = Player.new
    @player1.assign_marker('X')
    @player2 = Player.new
    @player2.assign_marker('O')
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @current_player = rand(2).to_i == 0 ? @player1 : @player2
    @free_positions = @board.dup.flatten
    puts "#{@current_player.name} will go first!"
    print_board
    while true
      place_marker
      print_board
      break if winner?
      if @free_positions.empty?
        puts "It's a draw."
        break 
      end
      switch
    end
  end

  def place_marker
    while true
      puts "#{@current_player.name}, enter a position you would like to mark: "
      position = gets.chomp.to_i
      if @free_positions.include?(position)
        z = position - 1
        x = (z / 3).truncate
        y = (z % 3)
        @board[x][y] = @current_player.marker
        @free_positions.delete_if { |free_position| free_position == position }
        return
      else
        puts 'This position is taken or this is not a valid input. Please try again.'
      end
    end
  end

  def switch
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def winner?
    board = @board.flatten
    indexes = []
    i = 0
    while i < 9
      indexes.push(i + 1) if board[i] == @current_player.marker
      i += 1
    end

    j = 0
    while j < LINES.length
      if LINES[j].all? { |e| indexes.include?(e) }
        puts "Congratulations! #{@current_player.name} is the winner!"
        return true
      end
      j += 1
    end
    return
  end

  def print_board
    @column_separator = ' | '
    @row_separator = '--+---+--'
    i = 0
    while i < 3
      j = 0
      while j < 3
        print "#{@board[i][j]}"
        print "#{@column_separator}" if j < 2
        j += 1
      end
      puts "\n" + @row_separator if i < 2
      i += 1
    end
    print "\n"
  end

  class Player
    def initialize
      puts "Please enter a player's name: "
      @name = gets.chomp
    end

    def assign_marker(marker)
      @marker = marker
    end
    attr_reader :marker, :name
  end
end

Game.new
