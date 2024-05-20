# Trying to break down the 3 components of RB101's mental model on block scope:
# Blocks create an inner scope; inner scopes can access outer scope variables;
# but not vice-versa.

# 1) Blocks create an inner scope
# - How/Why? Do we need to understand the mechanism behind -how- a closure creates 
#   its inner scope?

# 2) Inner scope can access outer scope variables
# - Because when a closure creates its inner scope for its block, it also creates
#   a binding - an encapsulation of the scope where it was defined (ie. the outer
#   scope, in relation). When the closure is executed, it retains access to the 
#   variables encapsulated by its binding, thereby giving its inner scope access
#   to the variables in the outer scope.

# 3) But outer scope cannot access inner scope. Why?
# - Do we need to understand the mechanism behind -how- a closure 'fences off' 
#   the variables initialized in its inner scope?
# eg.

# With nested blocks:

a = 1

p binding.local_variables #=> [:a]
loop do # Closure #1 is created here; `a` is encapsulated.
  b = 2

  p binding.local_variables #=> [:a, :b]
  loop do # Closure #2 is created here; `a` and `b` are encapsulated.
    break
  end
  break
end


# Non-nested:
loop do
  inner_var = 'Inner'
  break
end


# -Why/How- is inner_var inaccessible here?

# How does the main scope's binding work?
# binding.local_variables #=> []