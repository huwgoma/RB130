# Anagrams.
# Write a program that takes a word and a list of possible anagrams, and selects
#   the correct sublist that contains the anagrams of the word.
# eg. "listen", ["enlists", "google", "inlets", "banana"]
#     => ["inlets"]

# Anagram Rules:
# - Case-INSENSITIVE (Orchestra and Carthorse == true)
# - Same words are NOT anagrams (eg. corn, CORN, Corn == false)
# - Words with the same checksum (cumulative #ord values) are not automatically
#   anagrams (eg. mass (436), last (436) == false)
# - Partial-matching substrings do not count as anagrams
#   (eg. good, god, goody == false)

# Input:
# - #initialize: A String (@word)
# - #match: An array of strings (words)
# Output:
# - #match: An array containing all strings from words that are ANAGRAMS of
#   the Anagram object's @word.

# Data:
# - @word: Represents the `Anagram`'s word
#   - Possibly create a duplicate of @word to compare against:
#     - @word.downcase (case-insensitive)
# - Array of words given as input to #match.
# - Selection: Iterate through words and select all words that are anagrams
#   of @word.
#   - For each word in words:
#     - Compare the current word (downcased) against @word duplicate. If they
#       are equal, skip to the next word (ban identicals)
#     - Sort @word characters and word characters, and compare the resulting
#       character arrays. If they are equal, then they are anagrams. Add to result.
# # EOI => Return result array.

# Algorithm:
# Given an array of strings representing words:
# - Create a duplicate of @word to compare against (ie. comparison_word).
# Iterate through words. For each word:
# - If word.downcase is identical to comparison_word, skip to next word.
# - Sort the characters in comparison word and in current word. If the resulting
#   arrays are the same, select the current word.
# Return the selection array.

require 'pry'

# class Anagram
#   attr_reader :word, :word_dup

#   def initialize(word)
#     @word = word
#     @word_dup = word.downcase
#   end

#   def match(words)
#     words.select do |word|
#       word = word.downcase
#       next if word_dup == word

#       word_dup.chars.sort == word.chars.sort
#     end
#   end
# end

# Refactor #1: General Extraction
class Anagram
  attr_reader :word

  def initialize(word)
    @word = word.downcase
  end

  def match(words)
    words.select do |other_word|
      other_word = other_word.downcase
      next if same_word?(other_word)

      anagram?(other_word)
    end
  end

  private

  def same_word?(other_word)
    word == other_word
  end

  def anagram?(other_word)
    word.chars.sort == other_word.chars.sort
  end
end
