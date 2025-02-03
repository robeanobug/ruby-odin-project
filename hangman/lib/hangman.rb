# pseudocode
# choose a random word from the dictionary
# puts a blank for each letter in the secret word
# 
# loop do
# puts how many guesses the user has left
# get a character from the user
# -1 from number of guesses
# replace every blank that represents the guessed character
# puts the updated secret words with blanks
# check to see if the secret word matches the guessed characters, if so puts winner!
# check to see if the number of guesses == 0, if so puts "Sorry, maybe next time"
# end loop
# 
#    ____
#   |    |
#   |    O
#   |   /|\
# __|__ / \ 
#
require 'yaml'

def choose_word
  dictionary = IO.readlines('google-10000-english-no-swears.txt', chomp: true)
  
  loop do
  id = rand(0..dictionary.length - 1)
  @secret_word = dictionary[id]

    if @secret_word.length.between?(5, 12)
      break
    end
  end
end

def print_blanks
  @blanks = Array.new
  @secret_word.length.times do
    @blanks.push("_")
  end
  puts "\n" + @blanks.join(' ')
end

def update_blanks
  @update_blanks = false
  @secret_word.chars.each_with_index { |secret_char, index|
    if @guess == secret_char
      @blanks[index] = @guess
      @update_blanks = true
    end
  }
end

def update_num_guess
  unless @update_blanks
    @num_guess -= 1
  end
end

def save_game
  game_data = {
    secret_word: @secret_word,
    num_guess: @num_guess,
    already_guessed: @already_guessed,
    blanks: @blanks
  }

  File.open("saved_game.yml", "w") { |file| file.write(YAML.dump(game_data)) }
  puts "Game saved successfully!"
end

def load_game
  if File.exist?("saved_game.yml")
    loaded_data = YAML.load_file("saved_game.yml")
    @secret_word = loaded_data[:secret_word]
    @num_guess = loaded_data[:num_guess]
    @already_guessed = loaded_data[:already_guessed]
    @blanks = loaded_data[:blanks]
    puts "Game loaded successfully!"
    puts "\n" + @blanks.join(' ')
  else
    puts "No saved games found."
    exit
  end
end

@num_guess = 6
@already_guessed = Array.new(0)

puts "Would you like to (1) Start a new game or (2) Load a saved game?"
choice = gets.chomp
if choice == "2"
  load_game
else
  choose_word
  print_blanks
end

loop do
  puts "\n" + "You have #{@num_guess} incorrect guess(es) left. The letters you have already guessed are: #{@already_guessed}"
  puts 'Please enter a letter (or type "save" to save the game): '
  @guess = gets.chomp.downcase
  if @guess == "save"
    save_game
    exit
  end
  unless @guess.is_a?(String) && @guess.length == 1
    puts "Invalid guess"
    next
  end
  if @already_guessed.include?(@guess)
    puts "This letter has already been guessed!"
    next
  end
  @already_guessed.push(@guess)
  update_blanks
  update_num_guess
  puts "\n" + @blanks.join(' ')
  if @num_guess == 0
    puts "Sorry, maybe next time. The word was #{@secret_word}."
    exit
  end
  if @secret_word.chars == @blanks
    puts "\n" + "Congrats, you won!" + "\n"
    exit
  end
end