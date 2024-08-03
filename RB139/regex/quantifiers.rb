# Quantifiers Challenge - Write a regex that matches lines of text containing
# either:
#   3 comma-separated numbers, or 6+ comma-separated numbers.

# Test against:
# 123,456,789,123,345
# 123,456,,789,123
# 23,56,7
# 13,45,78,23,45,34
# 13,45,78,23,45,34,56

# There should be 3 matches:
#   23,56,7
#   13,45,78,23,45,34
#   13,45,78,23,45,34,56


# Match Text Lines - Delimit with ^ and $.
# Match Numbers (any # of digits) - \d+
#   Numbers are comma-separated (except first/last) - \d+, and \d+ (last)
# Two valid quantifiers - exactly 3 {3}, or 6+ {6,}

# Match 3 numbers first:
# /^(\d+,){2}\d+$/

# OR

# Match 6+ numbers:
# /^(\d+,){5,}\d+/$

# Combine:
# /(^(\d+,){2}\d+$)|(^(\d+,){5,}\d+)/


# Do this WITHOUT Alternation?
# Using ? (0 or 1, optional)

# Match 3 numbers, then optionally match 3+ numbers?
# /^(\d+,){2}\d+/ /(,(\d+,){2,}\d+)?/

# Match 2 numbers, optionally match 3+ numbers, then match 1 number.
# /^(\d+,){2}((\d+,){3,})?\d+$/

# ====================================================

# CHALLENGE #2 - Write a regex that matches HTML h1 header tags. 
# <h1>Main Heading</h1>
# <h1>Another Main Heading</h1>
# <h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>

# Match the opening/closing <h1> </h1> tags, and the content between them.
# - If multiple h1 tags appear on one line, only match the tags+content, nothing else
# Assume there are no nested tags.

# eg. Matches
# <h1>Main Heading</h1>
# <h1>Another Main Heading</h1>
# <h1>ABC</h1>, <h1>DEF</h1>

# Assuming we are only matching <h1> tags:
# Match the opening tag (<h1>)
# Match the content - any character, zero or more times (lazy?)
# Match closing tag (</h1>)
# /<h1>.*?</h1>/