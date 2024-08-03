# Are /(ABC|abc)/ and /[Aa][Bb][Cc]/ equivalent regex?

# These two expressions are not equivalent. The first regex can only match one 
# of two possible substrings (ABC or abc), whereas the second regex can match 
# any combination of upper/lower case letters at each character position. For 
# example, the second regex will match ABc, Abc, aBc, aBC, etc., none of which
# will be matched by the first regex.


# Are /abc/i and /[Aa][Bb][Cc]/ equivalent?

# These two expressions are equivalent. The first regex matches any 3-character 
# sequence containing a followed by b followed by c, in either upper or lower case
# (denoted by the i flag). The second regex also matches any 3-character sequence;
# the first position can match either a or A, the second either b or B, and the 
# third either c or C (denoted by the character classes). Therefore, although the
# methodology differs, the end result is the same - both expressions will match
# any string containing a 3-character sequence with abc, case-insensitive.


# Challenge: Write a regex that matches a string that looks like a negated
# character class range - [^a-z], [^0-9], etc.
# (Match 6 characters; exclude the forward slashes.)

# Match: opening square bracket [
# Match: Caret ^
# Match: Any alphanumeric character
# Match: Hyphen - 
# Match: Any alphanumeric character
# Match: Closing square bracket ]

# /\[\^[a-zA-Z0-9]-[a-zA-Z0-9]\]/