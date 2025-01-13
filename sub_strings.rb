def substrings(words, dictionary)
  # creating result hash
  result = Hash.new(0)
# iterate over dictionary words
  dictionary.each do |word|
    # iterate over words array to find matches
    words.downcase.scan(word).each do |match|
      # fill the new result hash with the matching words and counts
      result[word] += 1
    end
  end
  result
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts "#1"
puts substrings("below", dictionary)
puts "#2"
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
