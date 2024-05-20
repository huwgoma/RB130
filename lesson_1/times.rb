# Create a custom #times method, mimicking Integer#times

# 5.times do |num|
#   puts num
# end

# Output:
# 0
# 1
# 2
# 3
# 4
# Return:
#=> 5


# Custom #times:
def times(number)
  counter = 0
  while counter < number
    yield(counter) if block_given?
    counter += 1
  end

  number
end



times(5) do |num|
  puts num
end
# Should produce the same output as above