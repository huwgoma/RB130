# Write a method that returns all fields in an inconsistently-formatted string.
# Spaces, tabs, and commas are all possible delimiters, and can occur multiple 
# times.

# Input: A string, separated by commas/spaces/tabs (possibly multiple)
# Output: An array of strings, where each string is a 'field' from the
#   given input string (delimited by c/s/t)

# Examples:
# fields("Pete,201,Student")     # ["Pete", "201", "Student"]
# fields("Pete \t 201   ,  TA")  # ["Pete", "201", "TA"]
# fields("Pete \t 201")          # ["Pete", "201"]
# fields("Pete \n 201")          # ["Pete", "\n", "201"] - \n is not a delimiter

# Data:
# - The string given as input
# - Split the input string on one or more occurrences of either 
#   Comma (,) ; space(' '); or tab (\t)
# - Return the resulting array of substrings

# Algorithm:
# - Given a string as input, str:
# - Split str into an array of substrings using a regex pattern:
#   - Split on 1+ occurrences of comma/space/tab
# - Return the resulting array of substrings.

def fields(str)
  str.split(/[,\t ]+/)
end

p fields("Pete,201,Student")     # ["Pete", "201", "Student"]
p fields("Pete \t 201   ,  TA")  # ["Pete", "201", "TA"]
p fields("Pete \t 201")          # ["Pete", "201"]
p fields("Pete \n 201")          # ["Pete", "\n", "201"]