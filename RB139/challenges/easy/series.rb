# Series.
# Write a program that will take a String of digits and return all possible 
#   consecutive number series of a specified length, from that string.

# Input: 
# - A String (of number characters)
# - An Integer (specifies the number of digits in the returned numbers)

# Output:
# - A nested Array; each subarray consists of consecutive digits from the input
#   string, of length <Length>
# - If <length> is greater than the input string's length, raise an error.

# Example:
# String = '01234'; length = 3
# => [[0, 1, 2], [1, 2, 3], [2, 3, 4]]
# String = '01234', length = 4
# => [[0, 1, 2, 3], [1, 2, 3, 4]]
# String = '01234', length = 6
# => Error

# Data:
# - The String given as input
# - An Integer specifying sub-array lengths (# of consecutive digits to take)
# - An array of subarrays returned as output
#   - Each subarray contains <length> number of consecutive digits from the string.

# Algorithm:
# Given a string (digits) and integer (length) as input:
# - If length is greater than the length of digits, raise an Error. Otherwise:

# Initialize a new array, series = []

# Iterate from 0..(string_length - length); For each digit:
# - Take a slice from the string, starting from the current index, for <length>
#   number of characters.
# - Convert the resulting string to an array of integers (chars.map(&:to_i))
#   - Add the array to series array
# EOI => Return series

require 'pry'

class Series
  attr_reader :digits

  def initialize(digits)
    @digits = digits
  end

  def slices(length)
    limit = digits.length - length
    raise ArgumentError if limit.negative?

    (0..limit).each_with_object([]) do |index, series|
      series << digits.slice(index, length).chars.map(&:to_i)
    end
  end
end


# ==============================
# Refactor: Launch School Solution (#each_cons)
#   #each_cons iterates over elements in consecutive groups of a specified size
#   - moving one element at a time.

# Given a string (digits) and integer (length) as input:
# - Convert string digits into an array of integer digits
# - Iterate over integer digits; for each digit, take <length> number of 
#   consecutive elements, add them to an array, and add the array to the 
#   results array.

# class Series
#   attr_reader :str_number
  
#   def initialize(str_number)
#     @str_number = str_number
#   end

#   def slices(length)
#     raise ArgumentError if length > str_number.size

#     series = []
#     str_number.chars.map(&:to_i).each_cons(length) do |digits|
#       series << digits
#     end
#     series
#   end
# end

#   If #each_cons is not given a block, it returns an Enumerator that can be 
#   converted into an array, containing the elements of the calling array 
#   divided into the subarrays of size <length>.
#   eg. [1, 2, 3].each_cons(2).to_a => [[1, 2], [2, 3]]

# class Series
#   attr_reader :str_number
  
#   def initialize(str_number)
#     @str_number = str_number
#   end

#   def slices(length)
#     raise ArgumentError if length > str_number.size

#     str_number.chars.map(&:to_i).each_cons(length).to_a
#   end
# end