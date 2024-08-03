# Sum of Multiples
# Write a program that takes a positive integer and an array of one or more
#   other numbers, and outputs the sum of all numbers in the array that are
#   1) multiples of the given integer
#   2) less than the given integer

# eg. List all natural numbers up to 20 (exclusive) that are multiples of
#     either 3 or 5:
#     => 3, 5, 6, 9, 10, 12, 15, 18
#     - Sum these multiples => 78.

# Input:
# - An Integer (integer)
# - An array of 1 or more integers (factors)
#   - Optional; If not given, default to [3, 5].

# Output:
# - An integer
#   - represents the sum of all numbers from 1 to the given integer that are
#     multiples of any number in factors (excluding integer itself)

# Data:
# - A target integer to iterate up to (exclusive)
# - An array of integers (factors) which we want to compare each iterating
#   integer against
#   - If current integer is divisible by any of the numbers in factors, add it to
#     the sum

# Algorithm:
# Given an integer (int) and array of integers (factors) as input:
# - Set factors to [3, 5] unless it is given.
# - Initialize a new variable, sum = 0
# - Iterate from 1* up to int (exclusive). For each number:
#   - If the current number is divisible by any of the numbers in factor,
#     add it to sum.
# EOI => Return sum.

require 'pry'

# # First Draft (Ugly)
# class SumOfMultiples
#   def self.to(integer)
#     self.new.to(integer)
#   end

#   attr_reader :factors

#   def initialize(*factors)
#     @factors = factors.empty? ? [3, 5] : factors
#   end

#   def to(integer)
#     sum = 0

#     1.upto(integer - 1) do |int|
#       if factors.any? { |factor| int % factor == 0 }
#         sum += int
#       end
#     end

#     sum
#   end
# end

# =====================================
# Refactor: SumOfMultiples#to
# Surely there is a better way than brute-force iterating from 1 - int-1.
# eg. 10: 1, 2, 3, 4, 5, 6, 7, 8, 9; Factors are [3, 5]

# Alternate Algorithm:
# Iterate through factors. For each factor:
# - Iterate from factor up to number (exclusive), iterating by factor (eg. 3 at once)
# - Add each number to an array unless array already contains number (from a previous
#   factor iteration)
# - Sum the array.

# class SumOfMultiples
#   def self.to(limit)
#     self.new.to(limit)
#   end

#   attr_reader :factors

#   def initialize(*factors)
#     @factors = factors.empty? ? [3, 5] : factors
#   end

#   def to(limit)
#     factor_multiples(limit).sum
#   end

#   def factor_multiples(limit)
#     factors.each_with_object([]) do |factor, multiples|
#       (factor...limit).step(factor) { |n| multiples << n }
#     end.uniq
#   end
# end

# ==============================
# Refactor #2: Use reduce in factor_multiples:
# - Start with an empty array (result)
# - Iterate through factors. For each factor:
#   - Create an array of integers ranging from factor to limit (exclusive).
#   - Add the range array to the multiples array.
# - Remove any duplicate values at the end of iteration.
class SumOfMultiples
  def self.to(limit)
    new.to(limit)
  end

  attr_reader :factors

  def initialize(*factors)
    @factors = factors.empty? ? [3, 5] : factors
  end

  def to(limit)
    factor_multiples(limit).sum
  end

  private

  def factor_multiples(limit)
    factors.reduce([]) do |multiples, factor|
      multiples + (factor...limit).step(factor).to_a
    end.uniq
  end
end
