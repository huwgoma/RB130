# Scrabble Score
# Write a program that, given a word, computes the Scrablle score for that word.

# Scrabble Tile Scores:
# A, E, I, O, U, L, N, R, S, T => 1
# D, G                         => 2
# B, C, M, P                   => 3
# F, H, V, W, Y                => 4
# K                            => 5
# J, X                         => 8
# Q, Z                         => 10

# Scoring: Sum the values of all tiles used in the word.
# eg. CABBAGE:
#     C (3) A (1) B (3) B (3) A (1) G (2) E (1) => 14

# Input:
# #initialize: A String, representing a word

# Output:
# #score: An Integer, representing the cumulative Scrabble score of the @word.

# Data:
# - A String (@word)
# - A conversion table for scrabble tile scores.
#   - Hash? Where keys are letters and values are scores
# - Iterate through the characters of @word. For each character:
#   - Retrieve the corresponding score value of the current character and
#     add it to the cumulative score sum.
# - Return the score sum.

# Algorithm:
# Initialize a new variable, score = 0
# Iterate through each character of @word. For each character:
# - Retrieve the score value of the current character, and add it to score.
#   - Note: Character scores are case-insensitive.
# Return score.
require 'pry'

# class Scrabble
#   TILE_SCORES = {
#     a: 1, e: 1, i: 1, o: 1, u: 1, l: 1, n: 1, r: 1, s: 1, t: 1,
#     d: 2, g: 2,
#     b: 3, c: 3, m: 3, p: 3,
#     f: 4, h: 4, v: 4, w: 4, y: 4,
#     k: 5,
#     j: 8, x: 8,
#     q: 10, z: 10
#   }

#   attr_reader :word

#   def self.score(word)
#     self.new(word).score
#   end

#   def initialize(word)
#     @word = word
#   end

#   def score
#     return 0 if word.nil?

#     word.downcase.strip.chars.reduce(0) do |value, char|
#       value += TILE_SCORES[char.to_sym]
#       value
#     end
#   end
# end

# ======================
# Refactor: Embedded Whitespace
# - If a string contains embedded whitespace, simply stripping it is not enough.
# - Remove all non-alphabetic characters from the string (replace with '')
#
# #score:
# - Return 0 if the word is nil.
# - Otherwise, replace all non-alphabetic characters from the string with '',
#   downcase the string, then iterate through the resulting string.
#   For each character:
#   - Retrieve the corresponding score value and add it to result (0).
# EOI => Return result.

# class Scrabble
#   TILE_SCORES = {
#     a: 1, e: 1, i: 1, o: 1, u: 1, l: 1, n: 1, r: 1, s: 1, t: 1,
#     d: 2, g: 2,
#     b: 3, c: 3, m: 3, p: 3,
#     f: 4, h: 4, v: 4, w: 4, y: 4,
#     k: 5,
#     j: 8, x: 8,
#     q: 10, z: 10
#   }

#   attr_reader :word

#   def self.score(word)
#     self.new(word).score
#   end

#   def initialize(word)
#     @word = word
#   end

#   def score
#     return 0 if word.nil?

#     sanitized_word = word.downcase.gsub(/[^a-z]/, '')

#     sanitized_word.chars.reduce(0) do |value, char|
#       value += TILE_SCORES[char.to_sym]
#       value
#     end
#   end
# end

# =======================================
# Refactor #2: Simplify the TILE SCORES conversion table structure.
# - Key: Character class (eg. /[AEIOULNRST]/i); Value: 1.
# TILE_SCORES = {
#   /[AEIOULNRST]/ => 1,
#   /[DG]/ => 2,
#   /[BCMP]/ => 3,
#   /[FHVWY]/ => 4,
#   /K/ => 5,
#   /[JX]/ => 8,
#   /[QZ]/ => 10
# }

# Algorithm
# #initialize: Accept a string as input. Save the string into @word.
#
# #score:
# - Sanitize @word:
#   - If @word is nil, return 0.
#   - Replace all non-alphabetic characters with an empty string (remove).
# - Initialize a new variable, value = 0 (for scrabble value of word).
# - Iterate through TILE_SCORES. For each pattern => value pair:
#   - Scan the string for the current pattern, returning an array of all matches.
#   - Add the current pattern's score value to value x number of times, where
#     x is the number of returned matches.
# - Return value.

class Scrabble
  TILE_SCORES = {
    /[aeioulnrst]/i => 1,
    /[dg]/i => 2,
    /[bcmp]/i => 3,
    /[fhvwy]/i => 4,
    /[k]/i => 5,
    /[jx]/i => 8,
    /[qz]/i => 10
  }

  def self.score(word)
    new(word).score
  end

  attr_reader :word

  def initialize(word)
    @word = word
  end

  def score
    return 0 if word.nil?

    alphabetic_word = word.gsub(/[^a-z]/i, '')

    TILE_SCORES.reduce(0) do |total, (pattern, value)|
      total + (value * alphabetic_word.scan(pattern).size)
    end
  end
end
