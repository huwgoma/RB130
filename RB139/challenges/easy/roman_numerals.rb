# Write some code that converts modern decimal numbers into their Roman number
# equivalents.
# - Roman numerals use I, V, X, L, C, D, and M.

# I => 1 (up to 3)    L => 50            M => 1000
# V => 5              C => 100 (century)
# X => 10             D = 500

# Each number can only have 1 leading and 3 trailing digits
# eg. IV => 4; VIII => 8; IX => 9; XIII => 13

# Modern Roman Numerals are written by expressing each digit separately, starting
#   with the left-most digit and skipping any digit with a value of zero.

# eg. 1990
# 1000 => M; 900 => CM (1000 - 100); 90 => XC (100 - 10)
# MCMXC

# eg. 2008
# 2000 => MMVIII

# Problem:
# - Create a RomanNumeral class with an Integer input (decimal number)
# - RomanNumeral#to_roman method - Returns a string representing the internal number
#   in Roman numeral form
# - Only up to 3000

# Examples:
# 1 => I; 2 => II; 3 => III
# 4 => IV; 5 => V; 6 => VI; 8 => VIII
# 9 => IX; 10 => X; 11 => XI
# 15 => XV, 16 => XVI, 19 => XIX

# Data:
# - Maybe a hash storing the hardcoded values?

# { 1: I, 5: V, 10: X, 50: L, 100: C, 500: D, 1000: M }

# - Starting from the decimal integer:
# - Iterate through each decimal digit, starting from ones and increasing
#   - If digit is 0, skip to the next digit
#   - Multiply current digit by factor (1, 10, 100, ...)
#   - Determine how to express the current digit factor (digit * factor) in roman

# Determine how to express current digit number in roman?
# - If number is a key in the hash, take that value -> end
# Otherwise:
# - Check the leading digit.
#   - 2 || 3: Multiply the leading digit by the current factor string
#     eg. 2 => 2 * hash[1] => 'II'
#     eg. 30 => 3 * hash[10] => 'XXX'

#   - 4: Add the (factor * 5) string to the factor string
#     eg. 4 => hash[1] + hash[5] => IV
#         40 => hash[10] + hash[50] => XL

#   - 6, 7, 8: Subtract 5 from leading digit; Add (factor * 5) string and
#              factor string * (leading digit - 5)
#     eg. 6 => hash[5*1] + hash[1] * (6-5) => 'V' + 'I'
#        70 => hash[5*10]+ hash[10] * (7-5) => 'LXX'

#   - 9: Add the factor string and NEXT factor string (factor * 10)
#     eg. 9 => hash[1] + hash[1 * 10] => IX
#        90 => hash[10]+hash[10*10] => XC

# Iterating from ones->thousands:
# As each decimal place numeral is solved, add it to the FRONT of the string

require 'pry'

# class RomanNumeral
#   attr_reader :number

#   NUMERALS = {
#     1 => 'I', 5 => 'V', 10 => 'X',
#     50 => 'L', 100 => 'C', 500 => 'D', 1000 => 'M'
#   }

#   DECIMAL_BASE = 10

#   def initialize(number)
#     @number = number
#   end

#   def to_roman
#     number.digits.each_with_object('').with_index do |(digit, roman), index|
#       next if digit.zero?

#       factor = DECIMAL_BASE ** index

#       str = NUMERALS[digit * factor] || decimal_to_roman(digit, factor)
#       roman.prepend(str)
#     end
#   end

#   private

#   def decimal_to_roman(digit, factor)
#     case digit
#     when 2, 3    then NUMERALS[factor] * digit
#     when 4       then NUMERALS[factor] + NUMERALS[factor * 5]
#     when 6, 7, 8 then NUMERALS[factor * 5] + (NUMERALS[factor] * (digit - 5))
#     when 9       then NUMERALS[factor] + NUMERALS[factor * DECIMAL_BASE]
#     end
#   end
# end

# ==========================================
# Refactor (Launch School Algorithm)
# - Write a solution that does NOT rely on ordering of Hash iteration (since
#   Hash iteration can be random on older Ruby versions.)

# NUMERALS = {
#   1000 => 'M', 500 => 'D', 100 => 'C', 50 => 'L',
#   10 => 'X', 5 => 'V', 1 => 'I'
# }

# Algorithm:
# - Create a new empty string, result = ''
# - Create a new pointer to @number (num)

# - Sort the keys of NUMERALS in descending order (1000 -> 1), then iterate through
#   the resulting array of decimal keys. For each decimal:
#   - Skip to the next (smaller) decimal, unless number is larger than decimal.
#   - Otherwise, determine the Roman string to be appended to result:
#     - 4 & 9 are special cases.
#       - If number starts with 4:
#       1) Add the Roman string corresponding to the current decimal key.
#       2) Add the Roman string corresponding to the PREVIOUS decimal key.
#          - Current * 5
#       - If number starts with 9:
#       1) Add the Roman String corresponding to the NEXT decimal key.
#          - Current / 5
#       2) Add the Roman String corresponding to the PREVIOUS decimal key.
#          - Current * 2
#     - Otherwise: Divide number by the current decimal.
#       - Add the Roman string corresponding to the current key, quotient # of times.
#     - Always: Reassign number to the remainder of the division.
# - Return the result string.
#
class RomanNumeral
  NUMERALS = {
    1000 => 'M', 500 => 'D', 100 => 'C', 50 => 'L',
    10 => 'X', 5 => 'V', 1 => 'I'
  }

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_roman
    remaining = number

    NUMERALS.keys.sort.reverse.each_with_object('') do |decimal, string|
      next unless remaining >= decimal

      multiplier, remainder = remaining.divmod(decimal)

      roman = if remaining.to_s.start_with?('4')
                NUMERALS[decimal] + NUMERALS[decimal * 5]
              elsif remaining.to_s.start_with?('9')
                remainder = remaining % ((decimal / 5) * 9)
                NUMERALS[decimal / 5] + NUMERALS[decimal * 2]
              else
                NUMERALS[decimal] * multiplier
              end

      string << roman
      remaining = remainder
    end
  end
end
