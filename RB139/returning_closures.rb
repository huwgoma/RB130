def counter
  count = 0
  [Proc.new { count += 1 }, Proc.new { count += 1 }]
end

c1, c2 = counter

2.times { c1.call }
4.times { c2.call }

c1.binding.eval('count') #=> 6
c2.binding.eval('count') #=> 6



# def sequences
#   counter = 0
#   [Proc.new { counter += 1 }, Proc.new { counter += 1 }] 
# end

# counter_1, counter_2 = sequences

# 2.times { counter_1.call }
# 4.times { counter_2.call }

# p counter_1.binding.eval('counter') # 6
# p counter_2.binding.eval('counter') # 6



# Methods and blocks can return closures in the form of Procs (and lambdas),
# which can then be subsequently called.

# Be mindful of which variables are actually encapsulated by the binding of
# a returned closure.


# In this code, the sequence method is invoked two times (Line 10 and 14), 
# returning two different Proc objects.
# Note that the two Procs have two distinct versions of the counter variable.
# - Because sequence is invoked twice; local method variables are re-initialized
#   on each method invocation, meaning that each Proc forms a closure with a 
#   completely separate version of the `counter` variable.



# If we were to tweak the sequence method to return two different Procs in the 
# *same* method invocation, like so:

# Since the two Procs were both defined in the same method invocation, they both
# form a closure with the same version of the `counter` variable.









# Modify this code so that mystery returns 7, without modifying any numbers
# def create_context(number)
#   # number is assigned to 1 when the Proc is created on L58
#   Proc.new { number += 1; puts number }
# end

# number = 1

# context = create_context(number)
# # Proc.new { |x| x + number}

# context.call
# context.call
# context.call
# context.call


# Then we can use that object

# y = 4
# p context.call(y) # 5

# # Modify number after binding creation
# number = 2

# # Binding maintains updated references (ie. number is 2)
# p context.call(y + number) #=> 4 + 2 + 2 => 8
# # This line should return 7. ie. 4 + 2 + 1

# In other words, we want the Proc's version of `number` to remain at 1, 
# even after it is reassigned.