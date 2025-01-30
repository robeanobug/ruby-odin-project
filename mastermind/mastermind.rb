# Steps in Pseudocode
# - make secret code of four numbers (options are 1-8)
# - get guess input from code breaker trying to hack
# - check guess to make sure is valid, else puts "Error: invalid input. Try again."
# - give feedback "correct numbers: @num ex: 4 correct positions: @position position: 1"
# - if @position == 4, put "congrats you won!"
# - if you've guessed 12 times, put "sorry you lost, maybe next time."
# - repeat the previous steps after step one

class Game
  def initialize
    @secret_code = Array.new(4)
    make_secret_code
    puts "secret code: #{@secret_code}"

    12.times do
      get_guess
      puts 'Error: Invalid input. Guess should be four integers between 1 through 8.' unless valid_guess?
      feedback
      if winner?
        puts 'Congrats you won!'
        exit
      end
    end
    puts 'Sorry, maybe next time.'
  end

  # make secret code of four numbers (options are 1-8)
  def make_secret_code
    @secret_code = @secret_code.map { |_e| rand(1..9) }
  end

  # get guess input from code breaker trying to hack
  def get_guess
    @guess = []
    puts 'Please enter your guess (ex: 1234): '
    @guess = gets.chomp.to_s.chars.map { |num| num.to_i }
  end

  # check guess to make sure is valid, else puts "Error: invalid input. Try again."
  def valid_guess?
    has_four_elements = @guess.length == 4
    valid_elements = @guess.all? { |e| e.is_a?(Integer) && e.between?(1, 9) }

    return false unless has_four_elements && valid_elements

    true
  end

  # give feedback "correct numbers: @num ex: 4 correct positions: @position position: 1"
  def feedback
    @corr_num = []
    secret = @secret_code.dup
    guesses = @guess.dup
    guesses.each_with_index do |guess, i|
      secret.each_with_index do |num, j|
        next unless guess == num

        @corr_num.push(guess)
        guesses[i] = 0
        secret[j] = 0
        break
      end
    end
    @corr_position = @secret_code.filter.with_index { |e, index| @guess[index] == e }
    puts "You guessed #{@corr_num.length} number(s) correctly and #{@corr_position.length} number(s) are in the correct position"
  end

  def winner?
    return unless @secret_code == @guess

    true
  end
end

Game.new
