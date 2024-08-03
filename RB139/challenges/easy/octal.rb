# Octal
# Write a program that takes an input string representing an octal number and
#   outputs the corresponding decimal integer. Invalid input should be interpreted
#   as octal 0.

# The only valid digits in an octal number are 0-7.

# Information:
# Octal numbers are a base-8 number system:
# - Each digit is multiplied by 8 to the power of (0++)
#   - eg. The rightmost digit is multiplied by 8 ** 0 => 1
#         Second-from-right ...                8 ** 1 => 8
#     etc. - The nth digit (starting from right) is multiplied by 8 ** (n-1).
# - The products are then summed.

# Input:
# - A String representing an Octal number.

# Output:
# - An integer representing the decimal number corresponding to the input Octal
#   number.
# - If the string contains any invalid characters (ie. not 0-7), return decimal 0.

# Examples:
# '233' (octal)
# - All characters are 0-7, so input is valid.
# - Digits from right-to-left are [3, 3, 2]. Iterate thru digits; for each digit:
#   - 3 * (8**0) + 3 * (8**1) + 2 * (8**2)
#     => 3 + 24 + 128 => 155 (decimal)

# Data:
# - The string provided as input (octal)
# - Verify that all characters in the string are 0-7.
# - Split the string into an array of digits 
# - Map over digits and replace each digit with its decimal value
#   - Multiply the current digit by 8 to the power of index
# - Sum the resulting array of decimal digits 
# - Return the sum

# Algorithm:
# Given a string as input, octal:
# - Verify that all characters in the string are 0-7.
#   - If this is not true, return 0.
# - Initialize a new variable, decimal = 0.
# - Otherwise, iterate over each character in the string, starting from the right.
#   - (Iterate in reverse order, with index).
#   - For each digit character:
#     - Calculate the decimal value of the current digit character:
#       - Multiply the current digit by the 8-base (8 ** index).
#     - Add the resulting decimal value to decimal.
# - EOI => Return decimal.

require 'pry'

# class Octal
#   BASE = 8

#   attr_reader :octal

#   def initialize(octal)
#     @octal = octal
#   end

#   def to_decimal
#     return 0 unless valid_octal?

#     decimal = 0
#     octal.chars.reverse_each.with_index do |digit, index|
#       decimal_value = digit.to_i * (BASE ** index)
#       decimal += decimal_value
#     end

#     decimal
#   end

#   private

#   def valid_octal?
#     (octal.scan(/[^0-7]/).size).zero?
#   end
# end


# ===============================
# Refactor: Iteration; Try to use reduce if possible

# class Octal
#   BASE = 8

#   attr_reader :number

#   def initialize(number)
#     @number = number
#   end

#   def to_decimal
#     return 0 unless valid_number?

#     number.reverse.chars.each_with_index.reduce(0) do |decimal, (digit, index)|
#       decimal + (digit.to_i) * (BASE ** index)
#     end
#   end

#   private

#   def valid_number?
#     (number.scan(/[^0-7]/).size).zero?
#   end
# end


# ====================================
# Refactor: Using #map and #sum instead of #reduce.

class Octal
  BASE = 8

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 unless valid_number?

    number.reverse.chars.map.with_index do |digit, index|
      (digit.to_i) * (BASE ** index)
    end.sum
  end

  private

  def valid_number?
    (number.scan(/[^0-7]/).size).zero?
  end
end