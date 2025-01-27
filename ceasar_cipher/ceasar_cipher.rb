def ceasar_cypher(string, shift_factor)
  string.chars.each do |char|
    if char.ord.between?(65, 90)
      shifted_char = ((char.ord - 65 + shift_factor) % 26) + 65
      print shifted_char.chr
    elsif char.ord.between?(97, 122)
      shifted_char = ((char.ord - 97 + shift_factor) % 26) + 97
      print shifted_char.chr
    else
      print char
    end
  end
end

ceasar_cypher('What a string!', 5)
