# Write a method that returns true if its argument looks like a URL; false if not.

# Input: A string
# Output: A boolean - true if input string looks like a URL; false otherwise.
# 'looks like URL?'
# => Start of string
# => http(s)://
# => one or more word characters
# => .
# => com (? ca? etc.) - do we have to worry about valid top-level domains? no for now
# => End of string

# Example:
# url?('https://launchschool.com')     # -> true
# url?('http://example.com')           # -> true
# url?('https://example.com hello')    # -> false
# url?('   https://example.com')       # -> false

# Data:
# - String given as input
# - Match string against url regex pattern
# - If matches, return true 
# - Otherwise, false 

# Algorithm:
# - Given a string as input, string:
# - Determine whether string looks like a url using a regex.
#   - For a string to look like a URL:
#     - Start with http (optionally s), ://
#     - One or more word characters (?)
#       - Valid DNS names? (alphanumeric, minus, period)
#     - End with .com
# - If it does, return true; otherwise, false.

def url?(string)
  string.match?(/\Ahttps?:\/{2}[-.a-z\d]+com\z/i)
end

p url?('https://launchschool.com')     # -> true
p url?('http://example.com')           # -> true
p url?('https://example.com hello')    # -> false
p url?('   https://example.com')       # -> false