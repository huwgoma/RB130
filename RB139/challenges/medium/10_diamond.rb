# TO REVISIT
require 'pry'
# Diamond

# Input: A String (Letter)
# Output: Prints a diamond to the console, starting with 'A' at the top/bottom, 
#   with the given letter at the horizontally-widest point.
# - First/Last row each contain one 'A'.
# - All other rows have 2 identical letters.
# - The diamond's width is equal to its height (symmetric)
# - Letters ascend to the middle point (given letter) and descend to the bottom

# Examples:
# A => A

# B:     C:         D: 
#  A        A          A
# B B      B B        B B
#  A      C   C      C   C
#          B B      D     D
#           A        C   C
#                     B B
#                      A 

# Data: 
# - String given as input - represents the letter to which the diamond must expand.
# - Array of letters from A up to target letter, back down to A
#   eg. [A, B, C, D, B, C, A]
# - Measurements to be taken:
#   - width of the diamond: equal to the size of letters.
#   - number of spaces between letters:
#     - No spaces between A (only 1 A)
#     - 1 space between B; increases by 2 per character until the target letter
#       is reached, then decreases by 2 per character.

# Algorithm:
# Given a string as input, target_letter:
# - Initialize an array of letters from A to target, then back down to A.
# - Calculate the width of the diamond (letters.size)
# - Set initial center_padding to 1.
# 
# Initialize a new empty string, diamond = ''
# Iterate through letters. For each letter:
# - If letter == 'A', add 'A', centered to diamond_width with spaces
# - Otherwise: Add letter + (' ' * center_padding) + letter, centered to width (' ')
# - End each substring with a newline.
# If letter == target, set descending to true,
# If descending is true, increment center padding by -2; otherwise, +2.

# class Diamond
#   def self.make_diamond(target)
#     letters = Array('A'...target) + Array('A'..target).to_a.reverse
#     width = letters.size
#     center_space = 1
#     descending = false

#     letters.each_with_object('') do |letter, diamond|
#       if letter == 'A'
#         diamond << "#{letter.center(width, ' ')}\n"
#         next
#       else
#         diamond << "#{letter}#{' ' * center_space}#{letter}".center(width, ' ') + "\n"
#       end

#       descending = true if letter == target
#       center_space = descending ? center_space - 2 : center_space + 2
#     end

#   end
# end


# =================================
# Launch School Solution 

# Problem:
# - The diamond always begins and ends with a single letter A
# - The second row ('B') has one space between the two letters 'B'.
#   - All subsequent rows have an additional 2 spaces between their two letters,
#     compared to the previous row.
# - The width of the longest row must also be applied to the shorter rows.
#   - ie. If 'D' row is 7 characters long, the 'A' row must also be 7 chars long.

# Algorithm:
# - Create a range of letters: 'A' up to the given letter, then back down to 'A'.
#   - The given letter should only appear once.
# - Calculate the max width of the diamond.
# - Iterate over letters. For each letter, create a 'row' (substring). 
# - Row Info:
#   - Should be centered with spaces (to the max_width.)
#   - Should end with a newline (\n) character.
#   - If the letter is A, it should contain a single letter 'A'.
#   - If the letter is B, it should contain 'B B' (1 space)
#   - Subsequent rows should contain 2 additional spaces between letters.
# - Center each row using spaces and max width.

# class Diamond
#   ALPHABET = Array('A'..'Z')

#   def self.make_diamond(target)
#     letters = Array('A'...target) + Array('A'..target).reverse
#     width = letters.size

#     letters.each_with_object('') do |letter, diamond|
#       diamond << (row(letter).center(width, ' ') + "\n")
#     end
#   end

#   class << self
#     private

#     def row(letter)
#       return letter if letter == 'A'

#       letter + spaces(letter) + letter
#     end

#     def spaces(letter)
#       return 0 if letter == 'A'

#       ' ' * ((ALPHABET.index(letter) * 2) - 1)
#     end
#   end
# end


# =============================
# Refactor: Trisha C Approach
# - Only make half of the diamond, then reverse it and add the second half.
# - Initialize empty array, first_half = []
# - Calculate the width of the diamond: The number of letters between A and 
#   target letter, multiplied by 2, subtracted by 1.
# - Iterate through letters; for each letter, create a substring representing
#   the row for that letter, and add it to first_half.
#   - If letter is A, add a single A, centered to width.
#   - Otherwise, calculate the number of spaces between the letters*, add two letters
#     on either side of the spaces, center to width, then add to first_half.
#     * Spaces based on index:
#       - (Index * 2) - 1
#   - Add the row substring to first_half
# - Create second_half: Reverse the first half, add it (excluding the max letter)
#   to first_half. (ie. exclude the second 'D' row, if 'D' is the given letter)
# - Join the resulting array with "\n"

# class Diamond
#   def self.make_diamond(target)
#     letters = Array('A'..target)
#     width = (letters.size * 2) - 1

#     first_half = letters.each_with_object([]).with_index do |(letter, diamond), index|
#       diamond << row(letter, index).center(width, ' ')
#     end
    
#     second_half = first_half.reverse[1..-1]

#     (first_half + second_half).join("\n") + "\n"
#   end

#   class << self
#     private
    
#     def row(letter, index)
#       return letter if letter == 'A'

#       spaces = ' ' * ((index * 2) - 1)
#       letter + spaces + letter
#     end
#   end
# end
