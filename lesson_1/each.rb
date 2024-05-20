# Custom Array#each method

[1, 2, 3].each { |num| "do nothing" }
# => Returns [1, 2, 3]

# Array#each iterates through the array, yields each element to the given block
# (eg. num), and returns the calling array


# Custom Array#each:
def each(array)
  index = 0
  while index < array.size
    yield(array[index]) if block_given? # Return Enumerator? if not
    index += 1
  end
  array
end


p each([1, 2, 3]) { |num| puts num }
# 1
# 2 
# 3
# => [1, 2, 3]