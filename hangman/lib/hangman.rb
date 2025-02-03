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

def choose_word
  dictionary = IO.readlines('google-10000-english-no-swears.txt', chomp: true)
  
  loop do
  id = rand(0..dictionary.length - 1)
  @secret_word = dictionary[id]

    if @secret_word.length.between?(5, 12)
      puts "\n", @secret_word # Debugging (remove later)
      break
    end
  end
end

def print_blanks
  blanks = "_ " * @secret_word.length
  puts "\n", blanks
end

def update_blanks
  
end

@num_guess = 6

choose_word
print_blanks
puts "\nYou have #{@num_guess} guess(es) left."
puts "Please enter a letter: "
guess = gets.chomp
@num_guess -= 1
update_blanks