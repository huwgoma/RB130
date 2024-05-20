# Array#select:
# - Is called on an Array
# - Takes a block
# - Iterates through each element of the array
# - Yields each element to the given block
# - If the return value of the block is truthy, 
#     add the current element to the return array.

# eg.
# array = [1, 2, 3, 4, 5]
# array.select(&:odd?)            #=> [1, 3, 5]
# array.select { |num| puts num } #=> []
# array.select { |num| num + 1 }  #=> [1, 2, 3, 4, 5] 


# Custom Array#select
def select(array)
  selection = []
  index = 0
  while index < array.size
    element = array[index]
    selection << element if yield(element)
    index += 1
  end
  selection
end


array = [1, 2, 3, 4, 5]
p select(array) { |num| num.odd? }  #=> [1, 3, 5]
p select(array) { |num| puts num }  #=> [] (plus 1 2 3 4 5 output)
p select(array) { |num| num + 1 }   #=> [1, 2, 3, 4, 5]

