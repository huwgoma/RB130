# Perfect Numbers
# Natural Numbers (1, 2, 3,...) can be classified in one of 3 categories:
# - Abundant
# - Perfect
# - Deficient

# Classification is done based on comparing the number and the sum of its positive
#  divisors.
# - Positive Divisor: A number that the target number can be divided by with no
#   remainder; excludes the number itself.
# - eg. The positive divisors of 15 are 1, 3, and 5.
# - The sum of the positive divisors for 15 are (1+3+5) => 9 (ALIQUOT SUM).

# Abundant: Aliquot sum > Original number
# Perfect: Aliquot sum == Original number
# Deficient: Aliquot sum < Original number.

# Input:
# PerfectNumber::Classify
# - Integer (representing the original number)

# Output:
# - String (abundant, perfect, or deficient)
# - If number is not positive, raises StandardError

# Examples:
# 6: Divisors are 1, 2, 3;  1 + 2 + 3 == 6 (PERFECT)
# 15: Divisors are 1, 3, 5; 1 + 3 + 5 < 15 (DEFICIENT)
# 24: Divisors are 1, 2, 3, 4, 6, 8, 12 ( sum > 24 - ABUNDANT)

# Data:
# - Integer given as input (original number)
# - Create an array of the integer's divisors (excluding itself)
# - Sum the divisors array and compare with the original number.

# Algorithm:
# Given an integer as input, original_number:
# - Create an array of the integer's positive divisors (excluding itself):
#   - Initialize an empty array, divisors = []
#   - Iterate from 1 up to the original number. For each number:
#     - Break iteration if the current number is already in divisors.
#     - Otherwise, divide original number by current number.
#       - If remainder is 0:
#         - Add current number to divisors; add quotient to divisors (unless
#           quotient == original number)
# - Sum the integers in divisors
# - Compare the sum against original number to determine the returned string.
#   - sum > original => 'abundant'
#   - sum == original => 'perfect'
#   - sum < original => 'deficient'

require 'pry'

# class PerfectNumber
#   def self.classify(original_number)
#     self.new(original_number).classify
#   end

#   attr_reader :original_number

#   def initialize(original_number)
#     raise StandardError unless original_number.positive?
#     @original_number = original_number
#   end

#   def classify
#     aliquot_sum = divisors_excluding_self.sum

#     if aliquot_sum == original_number
#       'perfect'
#     elsif aliquot_sum > original_number
#       'abundant'
#     elsif aliquot_sum < original_number
#       'deficient'
#     end
#   end

#   private

#   def divisors_excluding_self
#     1.upto(original_number - 1).each_with_object([]) do |number, divisors|
#       return divisors if divisors.include?(number)

#       quotient, remainder = original_number.divmod(number)

#       if remainder.zero?
#         divisors << number
#         divisors << quotient unless quotient == original_number
#       end
#     end
#   end
# end

# ==========================================
# Refactor: Only class methods
# class PerfectNumber
#   def self.classify(original_number)
#     raise StandardError unless original_number.positive?
#     aliquot_sum = divisors_excluding_self(original_number).sum

#     if aliquot_sum == original_number
#       'perfect'
#     elsif aliquot_sum > original_number
#       'abundant'
#     elsif aliquot_sum < original_number
#       'deficient'
#     end
#   end

#   def self.divisors_excluding_self(original_number)
#     1.upto(original_number - 1).each_with_object([]) do |number, divisors|
#       return divisors if divisors.include?(number)

#       quotient, remainder = original_number.divmod(number)

#       if remainder.zero?
#         divisors << number
#         divisors << quotient unless quotient == original_number
#       end
#     end
#   end

#   private_class_method :divisors_excluding_self
# end

# =================================================
# Refactor #2: Clean up iteration logic for divisors_excluding_self:
# - Iteration is only necessary up to the halfway point between 1 and the original
#   number (since anything above half cannot be a divisor).
# * 1 is a divisor for any number. Therefore, we can initialize the divisors array
#   with 1 [1], and iterate from 2, up to the number / 2.
#   - This should also allow us to eliminate the guarding logic against adding
#     the number to its own divisors list (number / 1 == number)

class PerfectNumber
  def self.classify(original_number)
    raise StandardError unless original_number.positive?

    aliquot_sum = divisors_excluding_self(original_number).sum

    case aliquot_sum <=> original_number
    when 1  then 'abundant'
    when 0  then 'perfect'
    when -1 then 'deficient'
    end
  end

  def self.divisors_excluding_self(original_number)
    2.upto(original_number / 2).each_with_object([1]) do |number, divisors|
      return divisors if divisors.include?(number)

      quotient, remainder = original_number.divmod(number)
      divisors.push(number, quotient) if remainder.zero?
    end
  end

  private_class_method :divisors_excluding_self
end
