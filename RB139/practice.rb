def sequence
  counter = 0
  Proc.new { counter += 1 }
end

s1 = sequence
p s1.call           # 1
p s1.call           # 2
p s1.call           # 3


s2 = sequence
p s2.call           # 1
p s1.call           # 4 (note: this is s1)
p s2.call           # 2


# def sequence(cntr)
#   # On each invocation, initialize new cntr var and point it at 0
#   # cntr += 1 simply reassigns cntr - not counter
#   Proc.new { cntr += 1 }
# end

# counter = 0

# s1 = sequence(counter)
# p s1.call           # => 1
# p s1.call           # => 2
# p s1.call           # => 3
# puts

# s2 = sequence(counter)
# p s2.call           # => 1
# p s1.call           # => 4 (note: this is s1)
# p s2.call           # => 2



# def sequence
#   counter = 0
#   [Proc.new { counter += 1 }, Proc.new { counter += 1 }]
# end

# proc, proc_2 = sequence
# p proc.call # 1 
# p proc.call # 2
# p proc.call # 3

# p proc_2.call # 4

# proc_3 = sequence # new method invocation, new copy of local method var counter





