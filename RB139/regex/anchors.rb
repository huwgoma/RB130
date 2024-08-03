# Challenge:
# Write a regex that matches an entire line of text, consisting of exactly 
# 3 words as follows:

# The first word is A or The
#   There is a single space following the first word.
# The second word is any 4-letter word.
#   There is a single space following the second word.
# The third and last word is either dog or cat.
#   No ending punctuation.

# Test:
'A grey cat'
'A blue caterpillar'
'The lazy dog'
'The white cat'
'A loud dog'
'--A loud dog'
'Go away dog'
'The ugly rat'
'The lazy, loud dog'

# /^(A|The) \b[a-zA-Z]{4}\b (dog|cat)$/
# or
# /\A(A|The) \b[a-zA-Z]{4}\b (dog|cat)\z/