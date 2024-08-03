/\s...\s/
# Doc in a big red box.
# Hup! 2 3 4

# Matches: 
#  big 
#  2 3 

# Why doesn't this pattern include Doc, red, box, or Hup,
# but does include 2 3?

# Doc, box, and Hup are not matched because they are not delimited (surrounded)
# by whitespace on both sides.
# -Doc does not follow any whitespace; D is the first character.
# -box is not matched because it is followed by a period (not a whitespace).
# -Hup is not matched because it is followed by an exclamation mark.

# -red is not matched because the regex engine matches the preceding space
#  with ' big ', resulting in 'red ' no longer having a preceding whitespace.
#   - Once a character is matched, it is 'consumed' and cannot be used again
#     for another match. 

# -2 3 is matched because it is a sequence of 3 characters ('2 3'), surrounded
# by a space character on each side.
