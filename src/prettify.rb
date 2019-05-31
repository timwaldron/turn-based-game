# frozen_string_literal: true

# Module for making output pretty
module Prettify
  def self.typewriter_text(timer, string_to_print)
    array_of_characters = string_to_print.split('')

    array_of_characters.each do |letter|
      print(letter)
      sleep(timer)
    end

    sleep(2)
    puts
  end

  def self.capitalize(item_to_capitalize)
    string_to_capitalize = item_to_capitalize.to_s

    # Capitalize each word in the string
    if string_to_capitalize.include?(' ')
      each_word_in_string = string_to_capitalize.split(' ')
      new_capitalized_string = ''

      each_word_in_string.each_with_index do |word, index|
        length_of_word = word.length
        capital_letter = word[0].upcase
        rest_of_word = word[1...length_of_word]

        new_capitalized_string += capital_letter + rest_of_word
        new_capitalized_string += ' ' if index < each_word_in_string.length - 1
      end

      return new_capitalized_string

    else # Single word to capitalize
      capital_letter = string_to_capitalize[0].upcase
      rest_of_word = string_to_capitalize[1...string_to_capitalize.length]
      return capital_letter + rest_of_word
    end
  end
end
