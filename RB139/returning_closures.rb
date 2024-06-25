# Methods and blocks can return closures in the form of Procs (and lambdas),
# which can then be 

# Be mindful of which variables are actually encapsulated by a closure's binding.

# def sequence
#   counter = 0
#   Proc.new { counter += 1 }
# end

# seq = sequence
# seq2 = sequence

# 3.times { seq.call }
# p seq.binding.eval('counter')  # 3

# 5.times { seq2.call }
# p seq2.binding.eval('counter') # 5

# p seq.binding.eval('counter')  # 3

# In this code, the sequence method is invoked two times (Line 10 and 14), 
# returning two different Proc objects.
# Note that the two Procs have two distinct versions of the counter variable.
# - Because sequence is invoked twice; local method variables are re-initialized
#   on each method invocation, meaning that each Proc forms a closure with a 
#   completely separate version of the `counter` variable.

# If we were to tweak the sequence method to return two different Procs in the 
# *same* method invocation, like so:
def sequences
  counter = 0
  [Proc.new { counter += 1 }, Proc.new { counter += 1 }] 
end

seq1, seq2 = sequences

3.times { seq1.call }
5.times { seq2.call }

p seq1.binding.eval('counter') # 8
p seq2.binding.eval('counter') # 8

# Since the two Procs were both defined in the same method invocation, they both
# form a closure with the same version of the `counter` variable.