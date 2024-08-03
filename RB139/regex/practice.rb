puts 'matched 1' if 'a b'.match(/\S/)
puts 'matched 2' if " \t\n\r\f\v".match(/\S/)


# Concatenating Ranges
/[a-zA-Z]/ # Matches any single alphabetic character

# Concatenating Character Classes
/[a-z][A-Z]/ # Matches any two-character sequence where the first character 
             # is lowercase and the second character is uppercase.