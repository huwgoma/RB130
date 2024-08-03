# Point Mutations
# Write a program to calculating the Hamming distance between 2 DNA strands.

# A point mutation replaces one base with another base at a single point (nucleotide)

# The HAMMING DISTANCE is the number of point mutations (ie. differences)
#   between 2 DNA strands, over equal length.

# GAGCCTACTAACGGGAT
# CATCGTAATGACGGCCT
# ^ ^ ^  ^ ^    ^^

# If two sequences are of unequal length, use the shorter length to compute.

# Problem:
# - Write a DNA#hamming_distance method that accepts a string representing
#   a strand of DNA, compares it against the DNA's own string of DNA, and returns
#   an integer representing the hamming distance (cumulative number of differences
#   at each character/point)
# - DNA objects are instantiated with a string representing the object's DNA.

# Input:
# - DNA#initialize: Accepts a String as input (@dna = dna)
#   - No validation? (Empty strings are okay according to test #1).
# - DNA#hamming_distance: Accepts another string as input (other_dna)

# Output:
# - Integer representing the cumulative number of differences between the two
#   strings.

# Data:
# - String representing DNA object's DNA - @dna
# - String passed as input to #hamming_distance
# - If the two strings are uneven lengths, use the shorter string.
# - Compare lengths of @dna and other_dna; iterate through the shorter dna
# - For each character, compare it with the character from the other dna strand
# - If characters are unequal, increment hamming by 1

# Algorithm:
# DNA#initialize:
# - Given a string as input, dna:
#   - Initialize @dna to dna.
# DNA#hamming_distance:
# - Given a string as input, other_dna:
# - Determine the shorter dna strand.
# - Initialize a new variable, distance = 0
# - Iterate through the shorter dna strand, with index. For each character:
#   - Compare the current character with the character at the same position in
#     the other (longer) dna strand.
#   - If characters are equal, do nothing; if unequal, increment distance by 1
# - EOI => Return distance

require 'pry'

# Initial:
# class DNA
#   def initialize(dna)
#     @dna = dna
#   end

#   def hamming_distance(other_dna)
#     distance = 0

#     short_strand, long_strand = sort_strands_by_length(other_dna)

#     short_strand.chars.each_with_index do |base, index|
#       distance += 1 if base != long_strand[index]
#     end

#     distance
#   end

#   private

#   def sort_strands_by_length(other_dna)
#     return [dna, other_dna] if dna.length == other_dna.length
#     [dna, other_dna].minmax_by(&:length)
#   end

#   attr_reader :dna
# end

# Refactor #1:
# Assign a short strand (to iterate) and a long strand.
# If the two strands are equal in length, default to iterating over @dna
# Otherwise, assign shorter strand to short_strand and vice versa.

# Sort the two strands (dna and other) by length.
# - If the two strands are the same length, no sorting will be done.
# - If the two strands are not the same length, shorter one will come first.

# class DNA
#   def initialize(dna)
#     @dna = dna
#   end

#   def hamming_distance(other_dna)
#     distance = 0

#     short_strand, long_strand = [dna, other_dna].sort_by(&:length)

#     short_strand.chars.each_with_index do |base, index|
#       distance += 1 if base != long_strand[index]
#     end

#     distance
#   end

#   private attr_reader :dna
# end

# Refactor #2: reduce
# - Seems like a good use case for reduce; Reduce the iteration over the DNA
#   strand down to a single integer.
# reduce.with_index(memo, element)
# class DNA
#   def initialize(dna)
#     @dna = dna
#   end

#   def hamming_distance(other_dna)
#     short_strand, long_strand = [dna, other_dna].sort_by(&:length)
#     # Can't do reduce.with_index - why?
#     short_strand.chars.each_with_index.reduce(0) do |distance, (base, index)|
#       distance += 1 unless base == long_strand[index]
#       distance
#     end
#   end

#   private attr_reader :dna
# end

# Refactor #3: count
# - Iterate through the shorter string (with index) and count the number of chars
#   where the current char does not match the corresponding char in the opposing
#   string.
class DNA
  def initialize(dna)
    @dna = dna
  end

  def hamming_distance(other_dna)
    short_strand, long_strand = [dna, other_dna].sort_by(&:length)

    short_strand.chars.each_with_index.count do |base, index|
      base != long_strand[index]
    end
  end

  private

  attr_reader :dna
end
