# Custom Set
# Create a custom set type.
# A Set is a collection of unique and unordered values.
# - Assume all elements of a set are numbers.

# Methods:
#   #initialize - Accepts an optional Array argument
#   - Duplicate values are removed 
#   #empty?: Returns true if the Set has no elements, false otherwise.
#   #contains?: Returns true if the Set contains the specified obj, false otherwise.
# 
#   #subset?: Returns true if the calling Set is a subset of the given Set
#   - ie. All elements in the calling Set are contained in the given Set

#   #disjoint?: Returns true if the calling and given Sets have no elements in 
#     common.
#   - Default to true: If one or both of the Sets are empty, returns true

#   #eql?: Returns true if the calling and given sets have the same elements
#   - Default to true: Returns true for empty sets

#   #add: Adds the given object to the calling Set
#   - To the end of the set? but order doesn't really matter
#   - If a duplicate element is added, it is ignored

#   #intersection: Returns a new Set object containing all shared elements b/w
#     the calling and given Sets

#   #difference: Returns a new Set object containing all elements in the CALLING
#     Set that are not in the given Set

#   #union: Returns a new Set containing all unique elements from the calling and 
#     given Sets.
#   - Duplicate values are removed.

# ------------------

# Data:
# - Store internal representation as a Hash with identical keys-values?
#   - This will provide fast lookup and also automatically overwrite duplicate
#     values.
#   eg. { 1 => 1, 2 => 2, 3 => 3 }
#   - Can be converted to array with .keys or .values

# - Or store as an Array with uniq values?
#   - Slower but mroe readable

# Algorithms:
# #subset?: Calculate the difference between the calling set's elements and the 
#   given set's elements.
#   - Return an array of all elements from the calling Set that are NOT in the given
#     Set. 
#   - If this array is empty, that means all elements in the calling Set are in the
#     given Set; therefore, the calling Set is a subset of the given Set
# #disjoint?: Compute the array of all elements from the calling Set that are NOT
#   in the given set.
#   - If either calling or given set is empty, return true automatically (?)
#   - If the returned array is identical to the calling Set's array, return
#     true. Otherwise false.
#   eg. [1, 2].diff[3, 4] => [1, 2]
#       [1, 2].diff[2, 3] => [1]