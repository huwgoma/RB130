require 'pry'
# Enumerable#reduce
# "Folds/accumulates" a collection into 1 object.
# eg. 
# result = [1, 2, 3].reduce do |acc, num|
#   puts "#{acc} #{num}"
#   acc + num
# end
# p result
# reduce iterates through each element of the calling array
# - yields each element to the block
# - ALSO yields a 'memo' to the block (memo = return value of the block)
#   (What is the memo value on the first iteration?)
#   - If memo is not given:
#     - Memo is assigned to the first array value
#     - Iteration starts from the SECOND array value
#   - If memo IS given:
#     - Iteration starts from the first array value

# - Return value of the block is assigned to memo for the next iteration
# - Final return value is the return value of the block on the last iteration

# Custom #reduce
def reduce(array, memo = nil)
  index = memo ? 0 : 1
  memo ||= array.first 

  while index < array.size
    element = array[index]
    memo = yield(memo, element) if block_given?
    index += 1
  end
  memo 
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }             # => 15
p reduce(array, 10) { |acc, num| acc + num }         # => 25
# reduce(array) { |acc, num| acc + num if num.odd? } # => NoMethodError: undefined method `+' for nil:NilClass


p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']