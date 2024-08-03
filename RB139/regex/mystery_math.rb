# Write a method that changes the *first* arithmetic operator in a string to
#   a question mark (?) and returns the resulting string.
# - Do not modify the original string.

# Input: A String
# Output: A new string, with the first arithmetic operator (+-/*) replaced with a 
#   question mark (?)

# Examples:
# mystery_math('4 + 3 - 5 = 2')
# # '4 ? 3 - 5 = 2'

# mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# # '(4 ? 3 + 2) / 7 - 1 = 1'

# Data:
# - String given as input (assume it contains at least one math operator?)
# - Substitute the first match of math operator (*-/+) with ?
# - Return the resulting string (create new string)

# Algorithm:
# Given a string as input, equation:
# - Find the first match of the arithmetic operators (+-/*) and transform it
#   to a ? (new string)
# - Return the resulting string

def mystery_math(equation)
  equation.sub(/[+\-*\/]/, '?')
end

p mystery_math('4 + 3 - 5 = 2')
# '4 ? 3 - 5 = 2'
p mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# '(4 ? 3 + 2) / 7 - 1 = 1'

# ==================================================
# Write a method that changes *every* arithmetic operator in a string to a ? and
#   returns the resulting string (don't mutate the original)

# Same as previous, but using gsub instead of sub

def mysterious_math(equation)
  equation.gsub(/[+\-*\/]/, '?')
end

p mysterious_math('4 + 3 - 5 = 2')
# '4 ? 3 ? 5 = 2'
p mysterious_math('(4 * 3 + 2) / 7 - 1 = 1')
# '(4 ? 3 ? 2) ? 7 ? 1 = 1'