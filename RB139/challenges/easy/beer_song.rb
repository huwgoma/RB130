# Beer Song
# Write a program that can generate the lyrics of the 99 bottles of beer song.

# Input/Output
# BeerSong#verse:
# - A non-negative Integer representing the verse number (string) to returned
#   - Basic Format: 99 bottles...take one down, 98 bottles...
#   - Verse 2: 2 bottles..take one down, 1 BOTTLE...
#   - Verse 1: 1 bottle...take IT down, NO MORE bottles..
#   - Verse 0: No more bottles..Go to to the store and buy some more, 99 bottles..
# BeerSong#verses:
# - Accepts 2 integers; returns all verses (strings) between those 2 numbers (inc.)
#   - The first integer represents the starting verse; the second represents
#     the ending verse.
#   eg. Verses(2, 0): 
#       - 2 bottles..take one down, 1 bottle...
#       - 1 bottle...take it down, no more bottles...
#       - No more bottles...go to the store and buy some more, 99 bottles..
# BeerSong#lyrics: 
# - No input; returns all verses from 99 to 0.

# Data: 
# - Build BeerSong#verse first.
#   - #verses can iterate from start to end and call #verse for each number.
#   - #lyrics can call #verses with 99 and 0.
# #verse: An integer given as input, representing the verse number.

# #number_of_bottles - Input: Integer; Output: String describing number of bottles.
# Integer: 0 => "no more", 1 => "1 bottle"
# - Otherwise: "#{integer} bottles"

# Components of return String:
# <number of bottles> of beer on the wall, <number of bottles> of beer. \n \
# <action>, <number_of_bottles>(<remaining_bottles>) of beer on the wall.
#   <action>
#   - Take one down and pass it around
#   - Go to the store and buy some more
#   <remaining bottles>
#   - Starting - 1, OR 99 if starting - 1 is negative.

# Algorithm (#verse):
# Given an integer as input, representing the number of the verse to output:
# - Determine the descriptor string for the starting number of bottles
# - Determine the action string for the starting number of bottles
# - Determine the descriptor string for the ending number of bottles.
# Put the string together and return it.

# #verses:
# Given two integers as input, representing the starting and ending verse numbers:
# Initialize a new empty string, verses = ''
# - Iterate from start down to end. For each verse number:
#   - Call #verse with the current number. Concatenate the string returned from
#     #verse to verses (with a newline; chop the last newline char)

# #lyrics:
# - Invoke #verses with start = 99, last = 0.

require 'pry'

class BeerSong
  def self.verse(n)
    <<~HEREDOC
    #{quantity_descriptor(n).capitalize} of beer on the wall, \
    #{quantity_descriptor(n)} of beer.
    #{action_descriptor(n)}, #{quantity_descriptor(remaining_bottles(n))} \
    of beer on the wall.
    HEREDOC
  end

  def self.verses(first, last)
    first.downto(last).each_with_object('') do |n, verses| 
      verses << "#{verse(n)}\n"
    end.chop
  end

  def self.lyrics
    verses(99, 0)
  end

  class << self # Define private class methods
    private

    def quantity_descriptor(n)
      case n
      when 0 then "no more bottles"
      when 1 then "1 bottle"
      else        "#{n} bottles"
      end
    end
  
    def action_descriptor(n)
      case n
      when 0 then "Go to the store and buy some more"
      when 1 then "Take it down and pass it around"
      else        "Take one down and pass it around"
      end
    end
  
    def remaining_bottles(n)
      n.zero? ? 99 : n - 1 
    end
  end
end