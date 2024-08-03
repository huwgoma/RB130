# Write a program to determine whether a triangle is equilateral, isosceles,
# or scalene.

# Rules:
# - An equilateral triangle has 3 sides of equal length; an isosceles triangle
#   has 2 sides of equal length; a scalene triangle has 3 sides w/ diff lengths.
# - For a shape to be a triangle at all, all sides must be greater than 0 length,
#   and the sum of lengths of any 2 sides must be greater than the length of the
#   third side.

# Input/Output:
# - Instantiate a Triangle object with 3 integer arguments,
#   representing the lengths of each side.
# - If the triangle is invalid, raise an ArgumentError.
#   - Invalid if:
#     - Any side is 0 or negative
#     - The 2 shortest sides are not longer than the longest side.

# - Triangle#kind: Returns a string representing the type of triangle.

# Data:
# - Perhaps store the lengths of each side in an array? (sorted min->max)
# - lengths.any? not positive (0 is not positive)
# - lengths (first two) > lengths (last)

# Algorithm:
# Given a Triangle class with 3 integer arguments, representing the 3 lengths:
# - Store the lengths in a sorted array (shortest to longest)
# - Confirm that the triangle lengths form a valid triangle:
#   - Raise Argument Error unless:
#     #valid?
#     - All sides are positive, AND the sum of the first 2 sides (shortest)
#       is greater than the last side (longest).
# - Triangle#kind: Return a string describing the type of triangle.
#   - If lengths are all equal, return 'equilateral'
#   - If there are 2 unique lengths, return 'isosceles'
#   - If there are 3 unique lengths, return 'scalene'

require 'pry'

# class Triangle
#   def initialize(side1, side2, side3)
#     @sides = [side1, side2, side3].sort
#     raise ArgumentError unless valid?
#   end

#   def kind
#     case sides.uniq.size
#     when 1 then 'equilateral'
#     when 2 then 'isosceles'
#     when 3 then 'scalene'
#     end
#   end

#   private

#   attr_reader :sides

#   def valid?
#     sides.all?(&:positive?) && sides.first(2).sum > sides.last
#   end
# end

# Refactor so that valid? returns a different ArgumentError depending on the error
# condition.
# - If not all sides are positive: "Negative/Zero Length"
# - If the longest side is longer than the sum of the other 2 sides:
#   "Triangle Inequality Theorem"

class Triangle
  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3].sort
    verify
  end

  def kind
    case sides.uniq.size
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    when 3 then 'scalene'
    end
  end

  private

  attr_reader :sides

  def verify
    raise ArgumentError, 'Negative/Zero Length' unless all_positive?
    raise ArgumentError, 'Invalid Triangle Lengths' unless valid?
  end

  def all_positive?
    sides.all?(&:positive?)
  end

  def valid?
    sides.first(2).sum > sides.last
  end
end
