# Why do both of these match Mississipi?
/\b([a-z]*i){3}[a-z]*\b/i
/\b([a-z]*i){3,}[a-z]*\b/i

# Mississippi
# ziti 0minimize7
# inviting illegal iridium


# 
/\b([a-z]*i){3}[a-z]*\b/i
# \b...\b denotes word boundaries
# 

# {1} [a-z]* matches the entire string (Mississipi)
#     i      matches the last i (backtrack) - (Mississip, i).
# {2} [a-z]* matches the p (backtrack) - (Mississi, p, i)

# {1} The first [a-z]* matches the entire string greedily (Mississipi)
#      Then backtracks when the engine moves to i (Mississip, i)
#      Backtracks 2 more times to satisfy the range constraint:
# {2} (Mississ, i) (pi)
# {3} (Miss, i), (ssipi)


# {1} - Missi
# {2} - ssi
# {3} - pi